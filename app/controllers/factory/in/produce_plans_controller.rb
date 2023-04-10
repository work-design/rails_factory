module Factory
  class In::ProducePlansController < ProducePlansController
    before_action :set_scenes, only: [:overview]
    include Controller::In


    def index
      q_params = {
        'book_finish_at-gt': Time.current
      }
      q_params.merge! organ_id: current_organ.provider_ids.uniq

      @produce_plans = ProducePlan.includes(:scene).default_where(q_params).order(produce_on: :asc).group_by(&:produce_on)
    end

    def show
    end

    private
    def set_scenes
      @scenes = Scene.order(id: :asc)
    end

    def self.local_prefixes
      [controller_path, 'factory/in/base', 'buy', 'me']
    end
  end
end
