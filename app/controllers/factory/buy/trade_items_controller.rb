module Factory
  class Buy::TradeItemsController < Buy::BaseController
    before_action :set_trade_item, only: [:show, :toggle, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:good_id)

      @trade_items = current_organ.member_trade_items.includes(:organ).default_where(q_params).page(params[:page])
    end

    def new
      @trade_item = TradeItem.new
    end

    def create
      @trade_item = TradeItem.new(trade_item_params)

      unless @trade_item.save
        render :new, locals: { model: @trade_item }, status: :unprocessable_entity
      end
    end

    def toggle
      if @trade_item.init?
        @trade_item.status = 'checked'
      elsif @trade_item.checked?
        @trade_item.status = 'init'
      end

      @trade_item.save
    end

    private
    def set_address
      @address = current_user.principal_addresses.find params[:principal_address_id]
    end

    def set_trade_item
      @trade_item = Trade::TradeItem.find(params[:id])
    end

    def trade_item_params
      params.fetch(:trade_item, {}).permit(
        :number
      )
    end

  end
end
