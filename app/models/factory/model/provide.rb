module Factory
  module Model::Provide
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :invite_token, :string, default: -> { SecureRandom.uuid }

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :provider, class_name: 'Org::Organ', optional: true

      belongs_to :taxon, counter_cache: true, optional: true

      has_many :production_provides, dependent: :destroy

      validates :provider_id, uniqueness: { scope: :taxon_id }, allow_blank: true

      after_initialize :sync_organ, if: :new_record?
    end

    def sync_organ
      self.organ_id = taxon&.organ_id
    end

    def invite_url
      Rails.application.routes.url_for(
        controller: 'org/board/organs',
        invite_token: invite_token,
        host: (organ.provider || organ).host
      )
    end

  end
end
