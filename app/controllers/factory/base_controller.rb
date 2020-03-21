class Factory::BaseController < RailsFactory.config.app_controller.constantize
  before_action :support_organ

end
