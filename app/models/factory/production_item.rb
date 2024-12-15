module Factory
  class ProductionItem < ApplicationRecord
    include Model::ProductionItem
    if defined? RailsSpace
      include Space::Ext::Storable
    end
  end
end
