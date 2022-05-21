module Factory
  class Panel::UnifiersController < Panel::BaseController

    def index
      q_params = {}
      q_params.merge! params.permit(:name, :code)

      @unifiers = Unifier.default_where(q_params).page(params[:page])
    end

  end
end
