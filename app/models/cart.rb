class Cart < ApplicationRecord
  include RailsTrade::Cart
  include RailsTrade::Amount
  include RailsFactory::Cart
end unless defined? Cart
