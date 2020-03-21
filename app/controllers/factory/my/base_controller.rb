class Factory::My::BaseController < RailsFactory.config.my_controller.constantize
  include RailsTrade::MyCart
  before_action :support_organ

end
