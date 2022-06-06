module Factory
  class Admin::ProductionItemsController < Admin::BaseController
    before_action :set_production
    before_action :set_production_item, only: [:show, :pdf, :print, :print_data, :edit, :update, :destroy]
    before_action :set_new_production_item, only: [:index, :new, :create]

    def index
      q_params = {}

      if @product_plan
        q_params.merge!('produced_at-gte': @product_plan.start_at, 'produced_at-lte': @product_plan.finish_at)
      end
      q_params.merge! params.permit('produced_at-gte', 'produced_at-lte')

      @production_items = @production_plan.production_items.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def batch
      (@production_plan.planned_count - @production_plan.production_items_count).times do
        @production_plan.production_items.build
      end
      @production_plan.save
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
      @production_plan = ProductionPlan.find params[:production_plan_id]
    end

    def set_new_production_item
      @production_item = @production_plan.production_items.build(production_item_params)
    end

    def set_production_item
      @production_item = ProductionItem.find(params[:id])
    end

    def production_item_params
      params.fetch(:production_item, {}).permit(
        :production_id,
        :qr_code,
        :qr_file,
        :came_at
      )
    end

  end
end
