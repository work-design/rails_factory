require 'active_support/configurable'

module RailsFactory #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_controller = 'ApplicationController'
    config.my_controller = 'MyController'
    config.admin_controller = 'AdminController'
    config.current_customer = :current_user
  end

end


