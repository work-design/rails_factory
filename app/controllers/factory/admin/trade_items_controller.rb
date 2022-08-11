module Factory
  class Admin::TradeItemsController < Admin::BaseController
    before_action :set_production
    before_action :set_trade_item, only: [:show, :edit, :update, :destroy, :print]

    def index
      q_params = {}
      q_params.merge! params.permit(:address_id, :produce_on)

      @trade_items = @production.trade_items.default_where(q_params).page(params[:page])
    end

    def print
      @item.print
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_trade_item
      @item = @production.trade_items.find(params[:id])
    end

    def trade_item_params
      params.fetch(:item, {}).permit(
        :number,
        :amount,
        :note,
        :extra,
        :status
      )
    end

  end
end
