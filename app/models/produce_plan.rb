class ProducePlan < ApplicationRecord
  include RailsFactory::ProducePlan
  include RailsWait::WaitFor if defined? RailsWait
end unless defined? ProducePlan
