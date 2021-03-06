module Factory
  class Admin::ProducePlansController < Admin::BaseController
    before_action :set_produce_plan, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:title)

      @produce_plans = ProducePlan.default_where(q_params).page(params[:page])
    end

    def new
      @produce_plan = ProducePlan.new
    end

    def create
      @produce_plan = ProducePlan.new(produce_plan_params)

      if @produce_plan.save
        render 'create'
      else
        render :new, locals: { model: @produce_plan }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @produce_plan.assign_attributes(produce_plan_params)

      unless @produce_plan.save
        render :edit, locals: { model: @produce_plan }, status: :unprocessable_entity
      end
    end

    def destroy
      @produce_plan.destroy
    end

    private
    def set_produce_plan
      @produce_plan = ProducePlan.find(params[:id])
    end

    def produce_plan_params
      p = params.fetch(:produce_plan, {}).permit(
        :title,
        :start_at,
        :finish_at,
        :state
      )
      p.merge! default_form_params
    end

  end
end
