module Factory
  class Admin::TradeItemsController < Admin::BaseController
    before_action :set_production
    before_action :set_trade_item, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:address_id)
      @trade_items = @production.trade_items.default_where(q_params).page(params[:page])
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
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_trade_item
      @trade_item = @production.trade_items.find(params[:id])
    end

    def trade_item_params
      params.fetch(:trade_item, {}).permit(
        :number,
        :amount,
        :note,
        :extra,
        :status
      )
    end

  end
end
