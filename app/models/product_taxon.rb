class ProductTaxon < ApplicationRecord
  include RailsCom::Taxon
  include RailsFactory::ProductTaxon
end unless defined? ProductTaxon
