module Factory
  class ProducePlansController < BaseController

    def index
      q_params = {
        produce_on: Date.today
      }
      q_params.merge! default_params
      q_params.merge! params.permit('name-like', :name)

      @produce_plans = ProducePlan.default_where(q_params).order(id: :asc).page(params[:page])
    end

    def show
    end


  end
end
