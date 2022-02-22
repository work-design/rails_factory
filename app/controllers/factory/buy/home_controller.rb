module Factory
  class Buy::HomeController < Buy::BaseController

    def index
      @produce_on = Date.today

      ids = ProducePlan.where(produce_on: @produce_on, organ_id: current_organ.provider_ids).select(:scene_id).distinct.pluck(:scene_id)
      @scenes = Scene.where(id: ids)
    end

  end
end
