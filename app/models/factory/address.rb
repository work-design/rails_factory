module Factory
  class Address < ApplicationRecord
    self.table_name = 'profiled_addresses'
<<<<<<< HEAD
    include Profiled::Model::Address if defined? RailsProfile
=======
>>>>>>> d588c0eb2e32626c3482c7725f3bdd919cdc0641
    include Model::Address
  end
end
