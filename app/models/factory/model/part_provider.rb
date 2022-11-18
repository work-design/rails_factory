module Factory
  module Model::PartProvider
    extend ActiveSupport::Concern

    included do
      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :product, inverse_of: :part_providers, counter_cache: true
      belongs_to :production

      #validates :product_id, uniqueness: { scope: [:provider_id] }
      
      before_validation :sync_from_production, if: -> { production && production_id_changed? }
      before_save :sync_to_part, if: -> { production && production_id_changed? }
    end

    def sync_from_production
      self.upstream_product_id = upstream_production.product_id
      self.cost_price = upstream_production.price
      self.provider_id = upstream_product.organ_id
      self.product ||= production.product
      self.organ = production.organ || product.organ
    end

    def sync_to_part
      #part.name = production.name
    end

    def sync_price_to_part
      part.import_price = self.cost_price
      part.save
    end

  end
end
