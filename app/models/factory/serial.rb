module Factory
  class Serial < ApplicationRecord
    include Model::Serial
    include Com::Ext::Taxon
  end
end
