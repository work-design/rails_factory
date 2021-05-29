module Factory
  class Cart < ApplicationRecord
    self.table_name = 'trade_carts'
    include Model::Cart
  end
end
