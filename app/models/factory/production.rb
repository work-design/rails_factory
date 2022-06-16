module Factory
  class Production < ApplicationRecord
    include Model::Production
    include Trade::Ext::Good if defined? RailsTrade
  end
end
