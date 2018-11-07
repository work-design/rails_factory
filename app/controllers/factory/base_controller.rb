class Factory::BaseController < RailsFactory.config.app_class.constantize

  def current_customer
    @current_customer ||= send(RailsFactory.config.current_customer)
  end

end
