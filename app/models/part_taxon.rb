class PartTaxon < ApplicationRecord
  include RailsTaxon::Node
  include RailsFactory::PartTaxon
end unless defined? PartTaxon
