module RailsFactory::CustomCart
  extend ActiveSupport::Concern

  included do
    belongs_to :cart
    belongs_to :total_cart
    belongs_to :custom, inverse_of: :custom_carts

    after_initialize if: :new_record? do
      self.total_cart = cart.total_cart if cart
    end
  end


end
