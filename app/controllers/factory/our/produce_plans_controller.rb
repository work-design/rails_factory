module Factory
  class Our::ProducePlansController < In::ProducePlansController

    def index
      q_params = {
        'book_finish_at-gt': Time.current
      }
      q_params.merge! organ_id: current_organ.provider_ids.uniq

      @produce_plans = ProducePlan.includes(:scene).default_where(q_params).order(produce_on: :asc).group_by(&:produce_on)
    end

    def show
    end

    def self.local_prefixes
      [controller_path, 'factory/in/base', 'our', 'me']
    end
  end
end
