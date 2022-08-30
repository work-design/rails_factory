module Factory
  class In::FactoryTaxonsController < In::BaseController
    before_action :set_factory_taxon, only: [:show, :edit, :update, :destroy, :actions, :import]

    def index
      @factory_taxons = FactoryTaxon.page(params[:page])
    end

    def import
      q_params = {}
      q_params.merge! params.permit(:organ_id)
      @products = @factory_taxon.products.default_where(q_params).page(params[:page])

      product_ids = @products.pluck(:id)
      @select_ids = PartProvider.default_where(default_params).where(product_id: product_ids).pluck(:product_id)
    end

    def productions
      @productions = Production.default_where(product_id: params[:product_id])
    end

    private
    def set_factory_taxon
      @factory_taxon = FactoryTaxon.find(params[:id])
    end

    def factory_taxon_params
      params.fetch(:factory_taxon, {}).permit(
        :name,
        :logo
      )
    end

  end
end
