module RailsFactory::CustomCart
  extend ActiveSupport::Concern

  included do
    belongs_to :cart
    belongs_to :total_cart
    belongs_to :custom, inverse_of: :custom_carts
  end


end
