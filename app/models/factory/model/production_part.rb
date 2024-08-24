module Factory
  module Model::ProductionPart
    extend ActiveSupport::Concern

    included do
      attribute :number, :integer, default: 1

      belongs_to :part_taxon, class_name: 'Taxon'
      belongs_to :product
      belongs_to :production
      belongs_to :part, class_name: 'Production'

      before_validation :sync_part_taxon, if: -> { part_id_changed? }
      before_validation :sync_product, if: -> { production_id_changed? }
      after_save :sync_to_production, if: -> { (saved_changes.keys & ['part_id', 'number']).present? }
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
      production.add_part_str!("#{part_id}_#{number}")
    end

    def destroy_to_production!
      production.remove_part_str!("#{part_id}_#{number}")
    end

  end
end
