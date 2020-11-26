class ProductionPart < ApplicationRecord
  include RailsFactory::ProductionPart
end unless defined? ProductionPart
