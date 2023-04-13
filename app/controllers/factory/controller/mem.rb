module Factory
  module Controller::Mem
    extend ActiveSupport::Concern

    included do
      before_action :require_client
    end

    def require_client
      return if current_client

      redirect_to url_for(controller: 'trade/mem/carts', action: 'list', **params.permit(:auth_token, :role_id))
    end
  end
end
