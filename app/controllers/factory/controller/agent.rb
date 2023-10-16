module Factory
  module Controller::Agent
    extend ActiveSupport::Concern

    included do
      layout 'me'
    end

    def set_cart
      options = {
        agent_id: current_member.id
      }
      options.merge! default_params

      @cart = Trade::Cart.where(options).find_or_create_by(good_type: 'Factory::Production', aim: 'use')
      @cart.compute_amount! unless @cart.fresh
    end

  end
end
