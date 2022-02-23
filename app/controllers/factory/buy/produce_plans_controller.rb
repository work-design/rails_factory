module Factory
  class Buy::ProducePlansController < ProducePlansController

    def index
      q_params = {
        'book_finish_at-gt': Time.current
      }
      q_params.merge! default_params

      @produce_plans = ProducePlan.includes(:scene).default_where(q_params).order(id: :asc).group_by(&:produce_on)
    end

    def show
    end

    def self.local_prefixes
      [controller_path, 'factory/buy/base', 'buy', 'me']
    end
  end
end
