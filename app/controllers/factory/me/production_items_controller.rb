module Factory
  class Me::ProductionItemsController < Me::BaseController
    before_action :set_production_item, only: [:show, :print, :edit, :update, :qrcode, :in, :out]
    before_action :set_item_from_scan, only: [:in, :out]

    def index
      q_params = {}

      if @product_plan
        q_params.merge!('produced_at-gte': @product_plan.start_at, 'produced_at-lte': @product_plan.finish_at)
      end
      q_params.merge! params.permit('produced_at-gte', 'produced_at-lte')

      @production_items = @production_plan.production_items.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def in
      if @item.is_a?(Space::Grid)
        @production_item.grid = @item
        @production_item.state = 'grid_in'
      elsif @item.is_a?(Space::Room)
        @production_item.room = @item
        @production_item.state = 'grid_in'
      end
      @production_item.save
    end

    def out
      if @item.is_a?(Space::Grid)
        @production_item.grid = @item
        @production_item.state = 'grid_out'
      elsif @item.is_a?(Space::Room)
        @production_item.room = @item
        @production_item.state = 'grid_out'
      end
      @production_item.save
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

    def set_item_from_scan
      g = params[:result].scan(RegexpUtil.more_between('grids/', '/qrcode'))
      if g.present?
        return @item = Space::Grid.find g[0]
      end
      r = params[:result].scan(RegexpUtil.more_between('rooms/', '/qrcode'))
      if r.present?
        @item = Space::Room.find r[0]
      end
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
