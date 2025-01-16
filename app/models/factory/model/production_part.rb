module Factory
  module Model::ProductionPart
    extend ActiveSupport::Concern

    included do
      attribute :number, :integer, default: 1

      belongs_to :part_taxon, class_name: 'Taxon'
      belongs_to :product
      belongs_to :production
      belongs_to :part, class_name: 'Production'
      belongs_to :component

      before_validation :sync_part_taxon, if: -> { part_id_changed? }
      before_validation :sync_product, if: -> { new_record? || production_id_changed? }
    end

    def sync_product
      self.product_id = production.product_id
    end

    def sync_part_taxon
      self.part_taxon = part&.taxon
    end

  end
end
