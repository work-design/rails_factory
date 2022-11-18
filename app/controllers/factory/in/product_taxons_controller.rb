module Factory
  class In::ProductTaxonsController < In::BaseController
    before_action :set_product_taxon, only: [
      :show, :edit, :update, :destroy, :actions,
      :import, :productions
    ]
    before_action :set_providers, only: [:import, :productions]

    def index
      @factory_taxons = FactoryTaxon.page(params[:page])
    end

    def import
      q_params = {}
      q_params.merge! params.permit(:organ_id)
      @products = @product_taxon.factory_taxon.products.default_where(q_params).page(params[:page])

      product_ids = @products.pluck(:id)
      @select_ids = PartProvider.default_where(default_params).where(product_id: product_ids).pluck(:product_id)
    end

    def productions
      @productions = Production.default_where(product_id: params[:product_id])
    end

    def copy
      @product = Product.find params[:product_id]
      downstream_product = @product.downstreams.find_or_initialize_by(organ_id: current_organ.id)

      @production = @product.production.find(params[:id])
      downstream_production = downstream_product.productions.find_or_initialize_by(upstream_id: @production.id)
      downstream_production.organ = current_organ
      downstream_production.name = @production.name
      downstream_production.product_taxon_id = params[:product_taxon_id]

      downstream_production.save
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.find(params[:id])
    end

    def set_providers
      @providers = @product_taxon.factory_taxon.providers
    end

    def factory_taxon_params
      params.fetch(:factory_taxon, {}).permit(
        :name,
        :logo
      )
    end

  end
end
