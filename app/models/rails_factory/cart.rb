module RailsFactory::Cart
  extend ActiveSupport::Concern

  included do
    has_many :production_carts, ->{ order(customized_at: :desc) }, dependent: :destroy
    has_many :productions, through: :production_carts
  end

end
