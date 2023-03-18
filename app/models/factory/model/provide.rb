module Factory
  module Model::Provide
    extend ActiveSupport::Concern

    included do
      belongs_to :product_taxon

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :provider, class_name: 'Org::Organ'

      validates :provider_id, uniqueness: { scope: :product_taxon_id }

      after_initialize :sync_organ, if: :new_record?
    end

    def sync_organ
      self.organ_id = product_taxon&.organ_id
    end

  end
end
