module Factory
  module Controller::Agent
    include Controller::Application
    extend ActiveSupport::Concern

    included do
      layout 'agent'
    end

    def set_cart
      options = {
        agent_id: current_member.id
      }
      options.merge! default_params

      @cart = Trade::Cart.where(options).find_or_create_by(good_type: 'Factory::Production', aim: 'use')
      @cart.compute_amount! unless @cart.fresh
    end

    class_methods do
      def local_prefixes
        [controller_path, 'agent', 'me']
      end
    end

  end
end
