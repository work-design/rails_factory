module Factory
  class Cart < ApplicationRecord
    self.table_name = 'trade_carts'
    include Model::Cart
    include Trade::Model::Cart
  end
end
