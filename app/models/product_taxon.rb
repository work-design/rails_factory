class ProductTaxon < ApplicationRecord
  include RailsTaxon::Node
  include RailsFactory::ProductTaxon
end unless defined? ProductTaxon
