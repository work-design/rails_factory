module Factory
  class ProducePlan < ApplicationRecord
    include Model::ProducePlan
    include Wait::Ext::WaitFor if defined? RailsWait
  end
end
