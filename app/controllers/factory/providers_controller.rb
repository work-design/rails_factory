module Factory
  class ProvidersController < BaseController

    def search
      @providers = Provider.default_where('name-like': params[:q])
      render json: { results: @providers.as_json(only: [:id], methods: [:name_detail]) }
    end

  end
end
