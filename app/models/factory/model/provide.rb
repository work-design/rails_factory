module Factory
  module Model::Provide
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :invite_token, :string, default: -> { SecureRandom.uuid }

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :provider, class_name: 'Org::Organ', optional: true

      belongs_to :product_taxon, counter_cache: true, optional: true

      validates :provider_id, uniqueness: { scope: :product_taxon_id }, allow_blank: true

      after_initialize :sync_organ, if: :new_record?
    end

    def sync_organ
      self.organ_id = product_taxon&.organ_id
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
