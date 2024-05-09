module Factory
  module Model::ProductionPart
    extend ActiveSupport::Concern

    included do
      belongs_to :production
      belongs_to :product
      belongs_to :part, class_name: 'Production'
      belongs_to :part_taxon, class_name: 'ProductTaxon'

      after_initialize :sync_to_production, if: -> { part_id_changed? }
      before_validation :sync_part_taxon, if: -> { part_id_changed? }
      before_validation :sync_product, if: -> { production_id_changed? }
    end

    def sync_product
      self.product = production&.product
    end

    def sync_part_taxon
      self.part_taxon = part&.product_taxon
    end

    def sync_to_production
      p_ids = production.part_ids
      p_ids << part_id
      p_ids.sort!
      production.str_part_ids = p_ids.join(',')
    end

  end
end
