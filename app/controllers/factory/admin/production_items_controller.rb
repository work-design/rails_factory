module Factory
  class Admin::ProductionItemsController < Admin::BaseController
    before_action :set_production
    before_action :set_production_item, only: [:show, :edit, :update, :destroy, :update_delivery, :pdf, :print, :print_data]
    before_action :set_new_production_item, only: [:index, :new, :create]
    before_action :set_production_plan, if: -> { params[:production_plan_id] }

    def index
      q_params = {}

      if @production_plan
        q_params.merge!('came_at-gte': @production_plan.start_at, 'came_at-lte': @production_plan.finish_at)
      else
        q_params.merge! params.permit('came_at-gte', 'came_at-lte')
      end

      @production_items = @production.production_items.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def batch
      (@production_plan.planned_count - @production_plan.production_items_count).times do
        @production_plan.production_items.build
      end
      @production_plan.save
    end

    def delivery
      q_params = {}
      q_params.merge! params.permit(:state)

      @item = Trade::Item.find params[:item_id]
      @production_items = @production.production_items.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def update_delivery
      @item = Trade::Item.find params[:item_id]
      @production_item.do_rent(@item)
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
      @production = Production.find params[:production_id]
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
        :qr_file,
        :came_at
      )
    end

  end
end
