module Factory
  class Admin::ProductionProvidesController < Admin::BaseController
    before_action :set_production
    before_action :set_production_provide, only: [:show, :edit, :update, :destroy]
    before_action :set_provides, only: [:index]
    before_action :set_new_production_provide, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! params.permit(:good_type, :good_id)

      @production_provides = @production.production_provides.default_where(q_params).order(id: :asc).page(params[:page])
    end

    def search
      q_params = {}
      q_params.merge! params.permit('name-like', :organ_id)

      @productions = Production.default_where(q_params)
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
      @provides = @production.taxon.provides
    end

    def production_provide_params
      params.fetch(:production_provide, {}).permit(
        :verified,
        :selected,
        :provide_id,
        :upstream_product_id,
        :upstream_production_id
      )
    end

  end
end
