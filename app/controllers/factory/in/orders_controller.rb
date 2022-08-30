module Factory
  class In::OrdersController < Trade::In::OrdersController
    include Controller::In

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @orders = current_organ.member_orders.includes(:trade_items).default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def order_params
      p = params.fetch(:order, {}).permit(
        :quantity,
        :payment_id,
        :payment_type,
        :address_id,
        :invoice_address_id,
        :note,
        trade_items_attributes: {}
      )
      p.merge! current_cart_id: params[:current_cart_id] if params[:current_cart_id]
    end

    def self.local_prefixes
      [controller_path, 'factory/in/base']
    end

  end
end
