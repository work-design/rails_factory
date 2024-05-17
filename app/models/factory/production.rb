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
      {
        product_taxon_id: product_taxon_id,
        part_ids: part_ids
      }
    end
  end
end
