module Factory
  class ProductionItem < ApplicationRecord
    include Model::ProductionItem
    include Space::Ext::Storable if defined? RailsSpace
  end
end
