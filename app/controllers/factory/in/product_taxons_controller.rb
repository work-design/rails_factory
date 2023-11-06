module Factory
  class In::ProductTaxonsController < In::BaseController
    before_action :set_product_taxon, only: [
      :show, :edit, :update, :destroy, :actions,
      :import, :copy, :prune
    ]
    before_action :set_providers, only: [:import, :productions]
    before_action :set_production, only: [:copy, :prune]

    def index
      @factory_taxons = FactoryTaxon.page(params[:page])
    end

    def import
      q_params = {
        organ_id: @product_taxon.provider_ids
      }
      q_params.merge! params.permit(:organ_id) if @product_taxon.provider_ids.map(&:to_s).include? params[:organ_id]
      if @product_taxon.factory_taxon
        @products = @product_taxon.factory_taxon.products.default_where(q_params).page(params[:page])
      else
        @products = Product.default_where(q_params).page(params[:page])
      end

      product_ids = @products.pluck(:id)
      @select_ids = ProductionProvide.default_where(default_params).where(upstream_product_id: product_ids).pluck(:upstream_product_id)
      @imported_production_ids = ProductionProvide.default_where(default_params).distinct(:upstream_production_id).pluck(:upstream_production_id)
    end

    def copy
      downstream_provide = @production.downstream_provides.find_or_initialize_by(organ_id: current_organ.id)
      downstream_provide.sync_from_upstream(@product_taxon)
      downstream_provide.save
    end

    def prune
      production = @production.downstream_provides.find_by(organ_id: current_organ.id)
      production.destroy
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.find(params[:id])
    end

    def set_providers
      if @product_taxon.factory_taxon
        @providers = @product_taxon.factory_taxon.providers
      else
        @providers = current_organ.providers
      end
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
