module Factory
  class Admin::SceneAutomaticsController < Admin::BaseController
    before_action :set_scene
    before_action :set_new_scene_automatic, only: [:create]

    def index
      q_params = {}
      q_params.merge! params.permit(:name)

      @scenes = Scene.default_where(q_params).order(id: :asc).page(params[:page])
    end

    private
    def set_scene
      @scene = Scene.find params[:scene_id]
    end

    def set_new_scene_automatic
      @scene_automatic = @scene.scene_automatics.build(scene_automatic_params)
    end

    def scene_automatic_params
      p = params.fetch('scene_automatic', {}).permit(:advance_days)
      p.merge! default_form_params
    end

  end
end
