module Factory
  class Production < ApplicationRecord
    include Model::Production
    include Trade::Ext::Good
    include Trade::Ext::Rentable

    def item_extra
      attributes.slice('product_taxon_id')
    end
  end
end
