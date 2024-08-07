module Factory
  class Taxon < ApplicationRecord
    include Com::Ext::Taxon
    include Model::Taxon
  end
end
