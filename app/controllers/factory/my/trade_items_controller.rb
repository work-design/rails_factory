module Factory
  class My::TradeItemsController < My::BaseController
    before_action :set_address
    before_action :set_trade_item, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {
        good_type: 'Custom'
      }
      q_params.merge! params.permit(:good_id)
      @custom = Custom.find params[:good_id]
      @trade_items = @address.trade_items.default_where(q_params).page(params[:page])
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

    def show
    end

    def edit
    end

    def update
      @trade_item.assign_attributes(trade_item_params)

      unless @trade_item.save
        render :edit, locals: { model: @trade_item }, status: :unprocessable_entity
      end
    end

    def destroy
      @trade_item.destroy
    end

    private
    def set_address
      @address = current_user.principal_addresses.find params[:principal_address_id]
    end

    def set_trade_item
      @trade_item = TradeItem.find(params[:id])
    end

    def trade_item_params
      params.fetch(:trade_item, {}).permit(
      )
    end

  end
end
