module Factory
  module Model::ProductPart
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean, default: false

      belongs_to :product
      belongs_to :product_component, counter_cache: true
      belongs_to :part, class_name: 'Production'

      validates :part_id, uniqueness: { scope: :product_id }

      after_initialize :sync_product, if: :new_record?
    end

    def sync_product
      if product_component
        self.product_id = product_component.product_id
      end
    end

  end
end
