module Factory
  class Address < ApplicationRecord
    include Profiled::Model::Address if defined? RailsProfile
    include Model::Address
  end
end
