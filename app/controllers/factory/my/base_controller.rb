class My::BaseController < ApplicationController
  layout 'my'
  before_action :require_login_from_session
  default_form_builder 'MyFormBuilder' do |config|

  end

  def the_role_user
    current_user
  end

  def current_buyer
    current_user
  end

  def current_receiver
    current_user
  end

end
