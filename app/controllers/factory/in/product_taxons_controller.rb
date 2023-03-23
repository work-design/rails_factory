module Factory
  class In::ProductTaxonsController < In::BaseController
    before_action :set_product_taxon, only: [
      :show, :edit, :update, :destroy, :actions,
      :import, :productions, :copy
    ]
    before_action :set_providers, only: [:import, :productions]
    before_action :set_production, only: [:copy]

    def index
      @factory_taxons = FactoryTaxon.page(params[:page])
    end

    def import
      q_params = {
        organ_id: current_organ.provider_ids
      }
      q_params.merge! params.permit(:organ_id) if current_organ.provider_ids.map(&:to_s).include? params[:organ_id]
      @products = @product_taxon.factory_taxon.products.default_where(q_params).page(params[:page])

      product_ids = @products.pluck(:id)
      @select_ids = Product.default_where(default_params).where(upstream_id: product_ids).pluck(:upstream_id)
    end

    def productions
      @productions = Production.default_where(product_id: params[:product_id])
    end

    def copy
      downstream_product = @production.product.downstreams.find_or_initialize_by(organ_id: current_organ.id)
      downstream_product.product_taxon = @product_taxon

      downstream_production = downstream_product.proxy_productions.find_or_initialize_by(upstream_id: @production.id)
      downstream_production.organ = current_organ

      downstream_production.save
    end

    def prune
      @product = Product.find params[:product_id]
      @production = @product.proxy_productions.find(params[:production_id])
      @production.destroy
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.find(params[:id])
    end

    def set_providers
      @providers = @product_taxon.factory_taxon.providers
    end

    def set_production
      @production = Production.where(organ_id: @product_taxon.provider_ids).find params[:production_id]
    end

    def factory_taxon_params
      params.fetch(:factory_taxon, {}).permit(
        :name,
        :logo
      )
    end

  end
end
