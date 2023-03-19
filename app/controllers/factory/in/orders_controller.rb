module Factory
  class In::OrdersController < Trade::Admin::OrdersController
    include Controller::In

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @orders = current_organ.member_orders.includes(:items).default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def order_params

    end

    def self.local_prefixes
      [controller_path, 'factory/in/base']
    end

  end
end
