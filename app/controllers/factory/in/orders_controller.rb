module Factory
  class In::OrdersController < Trade::Admin::OrdersController
    before_action :set_order, only: [
      :show, :edit, :update, :refund, :payment_types, :edit_payment_type, :wait, :destroy, :cancel,
      :paypal_pay, :stripe_pay, :alipay_pay, :paypal_execute, :wxpay_pay, :wxpay_pc_pay
    ]

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @orders = current_organ.member_orders.includes(:trade_items).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def new
      current_organ.member_carts.each do |cart|
        cart.orders.build(order_params)
      end
    end

    def create
      @order = current_member.orders.build
      @trade_items = Trade::TradeItem.where(id: params[:ids].split(','))
      @trade_items.each do |trade_item|
        trade_item.order = @order
        trade_item.status = 'ordered'
        trade_item.address_id = params[:address_id]
      end

      if @order.save
        render 'create'
      else
        render :new, locals: { model: current_organ }, status: :unprocessable_entity
      end
    end

    def add
      @order = current_cart.orders.build
      @order.trade_items.build(good_id: params[:good_id], good_type: params[:good_type])
      @order.compute_amount
    end

    def direct
      @order = current_cart.orders.build(order_params)
      @order.organ = current_organ

      if @order.save
        render :direct
      else
        render :add, locals: { model: @order }, status: :unprocessable_entity
      end
    end

    # todo part paid case
    def wait
      if @order.all_paid?
        render 'show'
      else
        render 'wait'
      end
    end

    def payment_types
    end

    def edit_payment_type
    end

    def stripe_pay
      if @order.payment_status != 'all_paid'
        @order.stripe_charge(params)
      end

      if @order.errors.blank?
        render 'create', locals: { return_to: @order.approve_url }
      else
        render 'create', locals: { return_to: board_orders_url }
      end
    end

    def alipay_pay
      if @order.payment_status != 'all_paid'
        render 'create', locals: { return_to: @order.alipay_prepay_url }
      else
        render 'create', locals: { return_to: board_orders_url }
      end
    end

    def paypal_pay
      if @order.payment_status != 'all_paid'
        result = @order.paypal_prepay
        render 'create', locals: { return_to: result }
      else
        render 'create', locals: { return_to: board_orders_url }
      end
    end

    def paypal_execute
      if @order.paypal_execute(params)
        flase.now[:notice] = "Order[#{@order.uuid}] placed successfully"
        render 'create', locals: { return_to: board_order_url(@order) }
      else
        flase.now[:notice] =  @order.error.inspect
        render 'create', locals: { return_to: board_orders_url }
      end
    end

    def wxpay_pay
      @wxpay_order = @order.wxpay_order(current_wechat_app)

      if @wxpay_order['code'].present? || @wxpay_order.blank?
        render 'wxpay_pay_err', status: :unprocessable_entity
      else
        render 'wxpay_pay'
      end
    end

    def refund
      @order.apply_for_refund
    end

    def cancel
      @order.state = 'canceled'
      @order.save
    end

    private
    def current_wechat_app
      if params[:appid]
        Wechat::App.find_by appid: params[:appid]
      else
        super
      end
    end

    def set_order
      @order = Trade::Order.find(params[:id])
    end

    def order_params
      params.fetch(:order, {}).permit(
        :quantity,
        :payment_id,
        :payment_type,
        :address_id,
        :invoice_address_id,
        :note,
        trade_items_attributes: {}
      )
    end

    def self.local_prefixes
      [controller_path, 'factory/buy/base', 'buy', 'me']
    end

  end
end
