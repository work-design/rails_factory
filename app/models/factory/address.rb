module Factory
  class Address < ApplicationRecord
    self.table_name = 'profiled_addresses'
    include Profiled::Model::Address if defined? RailsProfile
    include Model::Address
  end
end
