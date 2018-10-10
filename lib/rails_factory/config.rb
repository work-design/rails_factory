require 'active_support/configurable'

module RailsFactory #:nodoc:
  include ActiveSupport::Configurable

  configure do |config|
    config.app_class = 'ApplicationController'
    config.my_class = 'MyController'
    config.admin_class = 'AdminController'
    config.api_class = 'ApiController'
  end

end


