module Factory
  class In::ProductTaxonsController < In::BaseController
    before_action :set_product_taxon, only: [:show, :edit, :update, :destroy, :actions]

    def index
      @product_taxons = ProductTaxon.page(params[:page])
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.find(params[:id])
    end


    def factory_taxon_params
      params.fetch(:factory_taxon, {}).permit(
        :name,
        :logo
      )
    end

  end
end
