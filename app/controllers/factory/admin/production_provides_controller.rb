module Factory
  class Admin::ProductionProvidesController < Admin::BaseController
    before_action :set_provide
    before_action :set_production_provide, only: [:show, :edit, :update, :destroy]
    before_action :set_new_production_provide, only: [:new, :create]

    def index
      q_params = {}

      @production_provides = @production.production_provides.default_where(q_params).order(id: :asc)
      @provides = Provide.where(default_params).where.not(id: @production_provides.pluck(:provide_id))
    end

    private
    def set_provide
      @provide = Provide.find params[:provide_id]
    end

    def set_production_provide
      @production_provide = @provide.production_provides.find(params[:id])
    end

    def set_new_production_provide
      @production_provide = @provide.production_provides.build(production_provide_params)
    end

    def production_provide_params
      params.fetch(:production_provide, {}).permit(
        :verified,
        :product_id,
        :production_id,
        :default,
        :cost_price,
        :upstream_product_id,
        :upstream_production_id
      )
    end

  end
end
