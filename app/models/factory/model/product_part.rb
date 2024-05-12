module Factory
  module Model::ProductPart
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean, default: false

      belongs_to :product_part_taxon, counter_cache: true
      belongs_to :product, counter_cache: true
      belongs_to :part, class_name: 'Production'

      validates :part_id, uniqueness: { scope: :product_id }

      after_initialize :sync_product, if: :new_record?
    end

    def sync_product
      self.product_id = product_part_taxon.product_id if product_part_taxon
    end

  end
end
