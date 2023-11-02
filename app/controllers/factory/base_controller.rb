module Factory
  class BaseController < BaseController
    include Controller::Application
    include Trade::Controller::Application if defined? RailsTrade
  end
end
