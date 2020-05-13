class Factory::My::BaseController < RailsFactory.config.my_controller.constantize
  before_action :support_organ

end
