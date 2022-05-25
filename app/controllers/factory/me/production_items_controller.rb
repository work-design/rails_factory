module Factory
  class Me::ProductionItemsController < Me::BaseController
    before_action :set_production_item, only: [:show, :print, :edit, :update, :qrcode]

    def index
      q_params = {}

      if @product_plan
        q_params.merge!('produced_at-gte': @product_plan.start_at, 'produced_at-lte': @product_plan.finish_at)
      end
      q_params.merge! params.permit('produced_at-gte', 'produced_at-lte')

      @production_items = @production_plan.production_items.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def warehouse_in
      r = params[:result].scan(RegexpUtil.more_between('production_items/', '/qrcode'))
      if r.present?
        @production_item = ProductionItem.find r[0]
        @production_item.assign_attributes params.permit(:room_id, :grid_id)
        @production_item.state = 'warehouse_in'
        @production_item.save
      end
    end

    def warehouse_out
      r = params[:result].scan(RegexpUtil.more_between('production_items/', '/qrcode'))
      if r.present?
        @production_item = ProductionItem.find r[0]
        @production_item.assign_attributes params.permit(:room_id, :grid_id)
        @production_item.state = 'warehouse_out'
        @production_item.save
      end
    end

    def qrcode
    end

    def print
      @production_item.print
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
