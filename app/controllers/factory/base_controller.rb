module Factory
  class BaseController < BaseController
    include Trade::Controller::Application if defined? RailsTrade
  end
end
