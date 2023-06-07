module Factory
  class Production < ApplicationRecord
    include Model::Production
    include Trade::Ext::Good
    include Trade::Ext::Rentable
  end
end
