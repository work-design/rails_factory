module Factory
  module Model::ProductPart
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean, default: false

      belongs_to :product, counter_cache: true
      belongs_to :part, class_name: 'Product'
      belongs_to :part_taxon, class_name: 'ProductTaxon'
      belongs_to :product_part_taxon, ->(o) { where(part_taxon_id: o.part_taxon_id) }, foreign_key: :product_id, primary_key: :product_id, counter_cache: true

      validates :part_id, uniqueness: { scope: :product_id }

      before_validation :sync_part_taxon, on: :create
    end

    def sync_part_taxon
      self.part_taxon_id = self.part.product_taxon_id
    end

  end
end
