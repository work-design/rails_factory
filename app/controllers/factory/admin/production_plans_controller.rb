module Factory
  class Admin::ProductionPlansController < Admin::BaseController
    before_action :set_production
    before_action :set_production_plan, only: [:show, :edit, :update, :destroy]
    before_action :set_new_production_plan, only: [:new, :create]
    before_action :set_scenes, only: [:new, :edit]

    def index
      q_params = {}
      q_params.merge! params.permit('start_at-gte', 'start_at-lte', 'produce_on-gte', 'produce_on-lte')

      @production_plans = @production.production_plans.default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_production_plan
      @production_plan = @production.production_plans.find(params[:id])
    end

    def set_new_production_plan
      @production_plan = @production.production_plans.build(production_plan_params)
    end

    def set_scenes
      @scenes = Scene.default_where(default_params)
    end

    def production_plan_params
      params.fetch(:production_plan, {}).permit(
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
