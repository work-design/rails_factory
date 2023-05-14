module Factory
  class Production < ApplicationRecord
    include Model::Production
    if defined? RailsTrade
      include Trade::Ext::Good
      include Trade::Ext::Rentable
    end
  end
end
