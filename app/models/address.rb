class Address < ApplicationRecord
  include RailsProfile::Address
  include RailsFactory::Address
end unless defined? Address
