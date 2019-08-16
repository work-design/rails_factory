class Custom < ApplicationRecord
  include RailsFactory::Custom
  include RailsTrade::Good
end unless defined? Custom
