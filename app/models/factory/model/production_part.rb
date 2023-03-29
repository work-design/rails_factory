module Factory
  module Model::ProductionPart
    extend ActiveSupport::Concern

    included do
      belongs_to :production
      belongs_to :product
      belongs_to :part, class_name: 'Production'
      belongs_to :part_taxon, class_name: 'ProductTaxon'

      before_validation :sync_part_taxon, if: -> { part_id_changed? }
      before_validation :sync_product, if: -> { production_id_changed? }
      before_validation :sync_to_production, if: -> { part_id_changed? }
    end

    def sync_product
      self.product = production&.product
    end

    def sync_part_taxon
      self.part_taxon = part&.product_taxon
    end

    def sync_to_production
      production.order_part_ids
    end

  end
end
