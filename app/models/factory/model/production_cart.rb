module Factory
  module Model::ProductionCart
    extend ActiveSupport::Concern

    included do
      attribute :state, :string, default: 'init'
      attribute :customized_at, :datetime, default: -> { Time.current }
      attribute :original_price, :decimal, default: 0

      belongs_to :cart
      belongs_to :user, optional: true
      belongs_to :product
      belongs_to :production, inverse_of: :production_carts

      enum :state, {
        init: 'init',
        checked: 'checked',
        carted: 'carted'
      }, default: 'init'

      before_validation :sync_product, on: :create
    end

    def sync_product
      self.product_id = production.product_id
    end

  end
end
