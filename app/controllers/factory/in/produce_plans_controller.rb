module Factory
  class In::ProducePlansController < ProducePlansController
    before_action :set_scenes, only: [:overview]
    include Controller::In

    def overview
      @produce_on = ProducePlan.where(organ_id: current_organ.provider_ids).effective.order(produce_on: :asc).first&.produce_on || Date.today

      ids = ProducePlan.where(produce_on: @produce_on, organ_id: current_organ.provider_ids).select(:scene_id).distinct.pluck(:scene_id)
      @scenes = Scene.where(id: ids)
    end

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
