module Factory
  class Address < ApplicationRecord
    self.table_name = 'profiled_addresses'
    include Model::Address
  end
end
