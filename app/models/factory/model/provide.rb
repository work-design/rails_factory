module Factory
  module Model::Provide
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :invite_token, :string, default: -> { SecureRandom.uuid }

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :provider, class_name: 'Org::Organ', optional: true

      belongs_to :factory_provider, optional: true

      has_many :production_provides, dependent: :destroy

      accepts_nested_attributes_for :production_provides

      validates :provider_id, uniqueness: { scope: :organ_id }, allow_blank: true

      before_validation :sync_organ, if: -> { factory_provider_id_changed? }
    end

    def sync_organ
      self.organ_id = factory_provider&.organ_id
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
