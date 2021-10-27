module Factory
  class ProducePlansController < BaseController

    def index
      q_params = {
        'produce_on-gte': Date.today
      }
      q_params.merge! default_params

      @produce_plans = ProducePlan.default_where(q_params).order(id: :asc).group_by(&:produce_on)
    end

    def show
    end


  end
end
