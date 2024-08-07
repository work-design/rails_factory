module Factory
  module Model::ProductionPart
    extend ActiveSupport::Concern

    included do
      belongs_to :part_taxon, class_name: 'Taxon'
      belongs_to :product
      belongs_to :production
      belongs_to :part, class_name: 'Production'

      after_initialize :sync_to_production, if: -> { part_id_changed? }
      before_validation :sync_part_taxon, if: -> { part_id_changed? }
      before_validation :sync_product, if: -> { production_id_changed? }
      after_destroy :destroy_to_production!
    end

    def sync_product
      self.product_id = production.product_id
    end

    def sync_part_taxon
      self.part_taxon = part&.taxon
    end

    private
    def sync_to_production
      p_ids = production.part_ids
      p_ids << part_id
      p_ids.uniq!
      p_ids.sort!
      production.str_part_ids = p_ids.join(',')
    end

    def destroy_to_production!
      p_ids = production.part_ids
      p_ids.delete part_id
      p_ids.sort!
      production.str_part_ids = p_ids.join(',')
      production.save!
    end

  end
end
