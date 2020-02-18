module RailsFactory::Cart
  extend ActiveSupport::Concern
  included do
    has_many :custom_carts, dependent: :destroy
    has_many :customs, through: :custom_carts
  end

end
