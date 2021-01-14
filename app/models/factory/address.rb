module Factory
  class Address < ApplicationRecord
    include RailsProfile::Address
    include Model::Address
  end
end
