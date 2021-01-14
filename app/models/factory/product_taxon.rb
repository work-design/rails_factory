module Factory
  class ProductTaxon < ApplicationRecord
    include Com::Ext::Taxon
    include Model::ProductTaxon
  end
end
