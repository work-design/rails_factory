module Factory
  class In::ProductTaxonsController < In::BaseController
    before_action :set_product_taxon, only: [:show, :edit, :update, :destroy, :actions, :import]

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

    def importx
      @production = Production.where(product_id: params[:product_id], id: params[:id]).take

      part = @production.provided_parts.build
      part.organ_id = current_organ.id
      part.name = @production.name
      part.part_taxon_id = params[:part_taxon_id]

      part.save
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
