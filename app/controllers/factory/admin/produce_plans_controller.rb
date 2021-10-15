module Factory
  class Admin::ProducePlansController < Admin::BaseController

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:title)

      @produce_plans = ProducePlan.default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
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
