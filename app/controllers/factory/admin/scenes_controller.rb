module Factory
  class Admin::ScenesController < Admin::BaseController

    def index
      @scenes = Scene.default_where(default_params).order(id: :asc).page(params[:page])

      q_params = {
        scene_id: @scenes.pluck(:id)
      }
      q_params.merge! default_params
      @scene_automatics = SceneAutomatic.default_where(q_params)
    end

  end
end
