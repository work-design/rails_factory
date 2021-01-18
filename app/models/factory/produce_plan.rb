module Factory
  class ProducePlan < ApplicationRecord
    include Model::ProducePlan
    include Wait::Model::WaitFor if defined? RailsWait
  end
end
