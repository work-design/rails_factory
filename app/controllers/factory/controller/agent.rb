module Factory
  module Controller::Agent
    extend ActiveSupport::Concern
    include Controller::Application
    include Org::Controller::Admin
    include Roled::Controller::Admin
    include Com::Controller::Admin

    included do
      layout 'agent'
      before_action :require_org_member
    end

    def set_cart
      @cart = Trade::Cart.get_cart(params, agent_id: current_member.id, **default_form_params)
    end

  end
end
