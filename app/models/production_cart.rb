class ProductionCart < ApplicationRecord
  include RailsFactory::ProductionCart
end unless defined? ProductionCart
