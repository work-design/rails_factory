module Factory
  class Production < ApplicationRecord
    include Model::Production
    if defined? RailsTrade
      include Trade::Ext::Good
      include Trade::Ext::Purchase
      include Trade::Ext::Rentable
    end
    if defined? RailsAudit
      include Auditor::Ext::Discard
      include Auditor::Ext::Audited
    end

    def item_extra
      attributes.slice('product_taxon_id')
    end
  end
end
