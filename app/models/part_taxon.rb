class PartTaxon < ApplicationRecord
  prepend RailsTaxon::Node
  include RailsFactory::PartTaxon
end unless defined? PartTaxon
