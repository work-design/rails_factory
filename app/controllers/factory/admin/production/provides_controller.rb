module Factory
  class Admin::Production::ProvidesController < Admin::Taxon::ProvidesController
    before_action :set_production
    before_action :set_provide, only: [:show, :edit, :update, :destroy, :actions, :invite]
    before_action :set_new_provide, only: [:new, :create]
    before_action :set_new_production_provide, only: [:new]

    def index
      @provides = Provide.where(default_params)
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_new_production_provide
      @provide.production_provides.build
    end

    def provide_params
      params.fetch(:provide, {}).permit(
        :provider_id,
        :name,
        production_provides_attributes: [:production_id]
      )
    end

  end
end
