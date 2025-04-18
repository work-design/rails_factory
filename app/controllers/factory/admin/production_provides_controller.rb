module Factory
  class Admin::ProductionProvidesController < Admin::BaseController
    before_action :set_production
    before_action :set_production_provide, only: [:show, :edit, :update, :destroy, :refresh, :actions]
    before_action :set_new_production_provide, only: [:new, :create]
    before_action :set_provides, only: [:new, :create]

    def index
      q_params = {}

      @production_provides = @production.production_provides.default_where(q_params).order(id: :asc)
      #@provides = Provide.where(default_params).where.not(id: @production_provides.pluck(:provide_id))
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_production_provide
      @production_provide = @production.production_provides.find(params[:id])
    end

    def set_new_production_provide
      @production_provide = @production.production_provides.build(production_provide_params)
    end

    def set_provides
      @provides = current_organ.provides
    end

    def production_provide_params
      params.fetch(:production_provide, {}).permit(
        :provide_id,
        :cost_price,
        :default,
        :upstream_product_id,
        :upstream_production_id
      )
    end

  end
end
