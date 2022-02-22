module Factory
  class Panel::ScenesController < Panel::BaseController

    def index
      q_params = {}
      q_params.merge! params.permit(:name)

      @scenes = Scene.default_where(q_params).order(id: :asc).page(params[:page])
    end

  end
end
