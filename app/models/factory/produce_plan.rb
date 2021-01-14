module Factory
  class ProducePlan < ApplicationRecord
    include Model::ProducePlan
    include RailsWait::WaitFor if defined? RailsWait
  end
end
