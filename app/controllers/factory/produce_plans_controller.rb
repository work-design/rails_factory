module Factory
  class ProducePlansController < BaseController

    def index
      q_params = {
        'book_finish_at-gt': Time.current
      }
      q_params.merge! default_params

      @produce_plans = ProducePlan.includes(:scene).default_where(q_params).order(id: :asc).group_by(&:produce_on)
    end

    def show
    end

  end
end
