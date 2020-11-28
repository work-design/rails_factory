module RailsFactory::ProductionCart
  extend ActiveSupport::Concern

  included do
    attribute :state, :string, default: 'init'
    attribute :customized_at, :datetime, default: -> { Time.current }
    attribute :original_price, :decimal, default: 0

    belongs_to :cart
    belongs_to :user
    belongs_to :production, inverse_of: :production_carts

    enum state: {
      init: 'init',
      checked: 'checked',
      carted: 'carted'
    }
  end

end
