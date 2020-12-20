class ProductionItem < ApplicationRecord
  include RailsFactory::ProductionItem
end unless defined? ProductionItem
