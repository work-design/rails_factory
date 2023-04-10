module Factory
  class ProducePlansController < BaseController

    def index
      q_params = {
        'book_finish_at-gt': Time.current
      }
      q_params.merge! default_params

      @produce_plans = ProducePlan.includes(:scene).default_where(q_params).order(produce_on: :asc).group_by(&:produce_on)
    end

    def overview
      @produce_on = ProducePlan.where(organ_id: current_organ.provider_ids).effective.order(produce_on: :asc).first&.produce_on || Date.today

      ids = ProducePlan.where(produce_on: @produce_on, organ_id: current_organ.provider_ids).select(:scene_id).distinct.pluck(:scene_id)
      @scenes = Scene.where(id: ids).order(id: :asc)
    end

    def show
    end

  end
end
