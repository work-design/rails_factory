module Factory
  class Admin::PurchaseItemsController < Admin::BaseController
    before_action :set_production
    before_action :set_item, only: [:show, :edit, :update, :destroy, :print]

    def index
      q_params = {}
      q_params.merge! params.permit(:address_id, :produce_on, :purchase_status)

      @items = @production.purchase_items.default_where(q_params).page(params[:page])
    end

    def print
      @item.print
    end

    def show
    end

    def edit
    end

    def update
      @item.assign_attributes item_params
      @item.save
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_item
      @item = @production.purchase_items.find(params[:id])
    end

    def item_params
      params.fetch(:item, {}).permit(
        :number,
        :amount,
        :note,
        :extra,
        :purchase_status
      )
    end

  end
end
