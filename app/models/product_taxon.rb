class ProductTaxon < ApplicationRecord
  prepend RailsTaxon::Node
  include RailsFactory::ProductTaxon
end unless defined? ProductTaxon
