module Factory
  class Admin::ProductionPlansController < Admin::BaseController
    before_action :set_production
    before_action :set_production_plan, only: [:show, :edit, :update, :destroy]
    before_action :prepare_form, only: [:new, :edit]

    def index
      @production_plans = @production.production_plans.order(id: :desc).page(params[:page])
    end

    def new
      @production_plan = @production.production_plans.build
    end

    def create
      @production_plan = @production.production_plans.build(production_plan_params)

      unless @production_plan.save
        render :new, locals: { model: @production_plan }, status: :unprocessable_entity
      end
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_production_plan
      @production_plan = @production.production_plans.find(params[:id])
    end

    def prepare_form
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
