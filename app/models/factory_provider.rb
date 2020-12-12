class FactoryProvider < ApplicationRecord
  include RailsFactory::FactoryProvider
end unless defined? FactoryProvider
