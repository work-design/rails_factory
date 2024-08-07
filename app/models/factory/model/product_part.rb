module Factory
  module Model::ProductPart
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean, default: false

      belongs_to :taxon_component, counter_cache: true
      belongs_to :product_component, counter_cache: true, optional: true
      belongs_to :part, class_name: 'Production'

      validates :part_id, uniqueness: { scope: :product_id }

      after_initialize :sync_product, if: :new_record?
    end

    def sync_product
      if product_part_taxon
        self.product_id = product_part_taxon.product_id
        self.taxon_id = product_part_taxon.taxon_id
      end
    end

  end
end
