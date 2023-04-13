module Factory
  class Our::CartsController < Our::BaseController
    include Controller::Our

    before_action :set_cart, only: [:show, :add]
    before_action :set_items, only: [:show, :list]

    def index
      @produce_on = ProducePlan.where(organ_id: current_organ.id).effective.order(produce_on: :asc).first&.produce_on || Date.today

      ids = ProducePlan.where(produce_on: @produce_on, organ_id: current_organ.id).select(:scene_id).distinct.pluck(:scene_id)
      @scenes = Scene.where(id: ids)
    end


  end
end
