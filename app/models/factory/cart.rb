module Factory
  class Cart < ApplicationRecord
    include Trade::Model::Cart
    include Trade::Model::Amount
    include Model::Cart
  end
end
