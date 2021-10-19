module Factory
  class BaseController < BaseController
    before_action :require_login if defined? RailsAuth
    include Trade::Controller::Application if defined? RailsTrade
  end
end
