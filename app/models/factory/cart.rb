module Factory
  class Cart < ApplicationRecord
    include RailsTrade::Cart
    include RailsTrade::Amount
    include Model::Cart
  end
end
