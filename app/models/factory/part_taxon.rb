module Factory
  class PartTaxon < ApplicationRecord
    include Com::Ext::Taxon
    include Model::PartTaxon
  end
end
