module Factory
  class ScenesController < BaseController
    before_action :set_scene, only: [:show]

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @scenes = Scene.all
    end

    def show
      @produce_on = ProducePlan.where(organ_id: current_organ.id).effective.order(produce_on: :asc).first&.produce_on || Date.today
    end

    private
    def set_scene
      @scene = Scene.find params[:id]
    end

  end
end
