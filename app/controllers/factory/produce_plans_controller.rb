module Factory
  class ProducePlansController < BaseController

    def index
      q_params = {
        'book_finish_at-gt': Time.current
      }
      q_params.merge! default_params

      @produce_plans = ProducePlan.includes(scene: { logo_attachment: :blob }).default_where(q_params).order(produce_on: :asc).group_by(&:produce_on)
    end

    def overview
      @produce_on = ProducePlan.where(default_params).effective.order(produce_on: :asc).first&.produce_on || Date.today

      ids = ProducePlan.where(produce_on: @produce_on, **default_params).select(:scene_id).distinct.pluck(:scene_id)
      @scenes = Scene.includes(logo_attachment: :blob).where(id: ids).order(id: :asc)
    end

    def show
    end

  end
end
