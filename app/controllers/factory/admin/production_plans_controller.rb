module Factory
  class Admin::ProductionPlansController < Admin::BaseController
    before_action :set_production
    before_action :set_production_plan, only: [:show, :edit, :update, :destroy]
    before_action :prepare_form, only: [:new, :edit]

    def index
      @production_plans = @production.production_plans.order(id: :desc).page(params[:page])
    end

    def new
      @product_plan = @product.product_plans.build
    end

    def create
      @product_plan = @product.product_plans.build(product_plan_params)

      unless @product_plan.save
        render :new, locals: { model: @product_plan }, status: :unprocessable_entity
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
      @produce_plans = ProducePlan.default_where(default_params)
    end

    def product_plan_params
      params.fetch(:product_plan, {}).permit(
        :scene_id,
        :start_at,
        :finish_at,
        :state,
        :planned_count
      )
    end

  end
end
