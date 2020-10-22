class PartTaxon < ApplicationRecord
  include RailsCom::Taxon
  include RailsFactory::PartTaxon
end unless defined? PartTaxon
