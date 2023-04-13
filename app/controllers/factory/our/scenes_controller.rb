module Factory
  class Our::ScenesController < ScenesController
    include Controller::Our

    def index
      q_params = {}
      q_params.merge! params.permit(:id, :payment_type, :payment_status, :state)

      @scenes = Scene.all
    end

    private
    def set_scene
      @scene = Scene.find params[:id]
    end

  end
end
