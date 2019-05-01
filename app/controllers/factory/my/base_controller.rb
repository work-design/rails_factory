class Factory::My::BaseController < RailsFactory.config.my_controller.constantize

  def current_customer
    @current_customer ||= send(RailsFactory.config.current_customer)
  end

end
