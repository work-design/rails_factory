module Factory
  class Admin::ProductionPartsController < Admin::BaseController
    before_action :set_production
    before_action :set_production_part, only: [:show, :edit, :update, :destroy]
    before_action :set_new_production_part, only: [:new, :create]
    before_action :set_scenes, only: [:new, :edit]

    def index
      q_params = {}
      q_params.merge! params.permit('start_at-gte', 'start_at-lte', 'produce_on-gte', 'produce_on-lte')

      @production_parts = @production.production_parts.default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_production_part
      @production_part = @production.production_parts.find(params[:id])
    end

    def set_new_production_part
      @production_part = @production.production_parts.build(production_part_params)
    end

    def production_part_params
      params.fetch(:production_part, {}).permit(
        :scene_id,
        :start_at,
        :finish_at,
        :produce_on,
        :state,
        :planned_count,
        :specialty
      )
    end

  end
end
