class Product < ApplicationRecord
  include RailsFactory::Product
end unless defined? Product
