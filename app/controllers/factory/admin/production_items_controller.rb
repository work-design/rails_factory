module Factory
  class Admin::ProductionItemsController < Admin::BaseController
    before_action :set_production
    before_action :set_production_item, only: [:show, :edit, :update, :destroy, :update_delivery, :pdf, :print, :print_data]
    before_action :set_new_production_item, only: [:index, :new, :create]

    def index
      q_params = {}
      q_params.merge! params.permit('came_at-gte', 'came_at-lte')

      @production_items = @production.production_items.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def batch_create
      params[:number].to_i.times do
        @production.production_items.build
      end
      @production.save
    end

    def delivery
      q_params = {}
      q_params.merge! params.permit(:state)

      @item = Trade::Item.find params[:item_id]
      @production_items = @production.production_items.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def update_delivery
      @item = Trade::Item.find params[:item_id]
      @production_item.do_hold(@item)
    end

    def print
      @production_item.print
    end

    def pdf
      send_data @production_item.to_pdf.render, type: 'application/pdf', disposition: 'inline'
    end

    def print_data
      render json: @production_item.to_cpcl.bytes
    end

    private
    def set_production
      @production = Production.default_where(default_filter_params).find params[:production_id]
    end

    def set_production_plan
      @production_plan = ProductionPlan.find params[:production_plan_id]
    end

    def set_new_production_item
      @production_item = @production.production_items.build(production_item_params)
    end

    def set_production_item
      @production_item = @production.production_items.find(params[:id])
    end

    def production_item_params
      params.fetch(:production_item, {}).permit(
        :production_plan_id,
        :code,
        :amount,
        :qr_file,
        :came_at
      )
    end

  end
end
