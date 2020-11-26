class Production < ApplicationRecord
  include RailsFactory::Production
  include RailsTrade::Good
end unless defined? Production
