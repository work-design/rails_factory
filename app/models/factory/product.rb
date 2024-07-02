module Factory
  class Product < ApplicationRecord
    include Model::Product
    include Auditor::Ext::Discard if defined? RailsAudit
    include Qingflow::Ext::Related if defined? RailsQingflow
  end
end
