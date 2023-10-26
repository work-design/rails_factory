module Factory
  class Production < ApplicationRecord
    include Model::Production
    include Trade::Ext::Good
    include Trade::Ext::Purchase
    include Trade::Ext::Rentable
    include Auditor::Ext::Discard if defined? RailsAudit

    def item_extra
      attributes.slice('product_taxon_id')
    end
  end
end
