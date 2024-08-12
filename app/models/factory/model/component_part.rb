module Factory
  module Model::ComponentPart
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean, default: false

      belongs_to :taxon
      belongs_to :product
      belongs_to :component, counter_cache: true

      belongs_to :part, class_name: 'Production'

      validates :part_id, uniqueness: { scope: :component_id }

      after_initialize :sync_product, if: :new_record?
      after_initialize :sync_taxon, if: :new_record?
    end

    def sync_product
      if product_component
        self.product_id = product_component.product_id
      end
    end

    def sync_taxon
      if taxon_component
        self.taxon_id = taxon_component.taxon_id
      end
    end

  end
end
