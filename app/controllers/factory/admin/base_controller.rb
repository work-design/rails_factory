class PmsAdmin::BaseController < ApplicationController
  include TheRole::Controller
  layout 'admin'
  before_action :require_login_from_session
  before_action :require_role

  default_form_builder 'AdminBuilder' do |config|

  end

  def current_manager
    current_user&.manager
  end

  def the_role_user
    current_user
  end

end
