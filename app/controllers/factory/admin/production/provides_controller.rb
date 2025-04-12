module Factory
  class Admin::Production::ProvidesController < Admin::ProvidesController
    before_action :set_production
    before_action :set_new_production_provide, only: [:new]

    def index
      @production_provides = @production.production_provides.order(id: :asc)

      except_ids = @production_provides.pluck(:provide_id)
      @provides = Provide.where(default_params).where.not(id: except_ids).page(params[:page])
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
