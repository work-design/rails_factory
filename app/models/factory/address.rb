module Factory
  class Address < ApplicationRecord
    include Profile::Model::Address if defined? RailsProfile
    include Model::Address
  end
end
