module Factory
  class Cart < ApplicationRecord
    include Model::Cart
    include Trade::Model::Cart
  end
end
