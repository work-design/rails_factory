class TotalCart < ApplicationRecord
  include RailsTrade::TotalCart
  include RailsTrade::Amount
  include RailsFactory::TotalCart
end unless defined? TotalCart
