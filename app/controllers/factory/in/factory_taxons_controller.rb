module Factory
  class In::FactoryTaxonsController < In::BaseController
    before_action :set_factory_taxon, only: [:show, :edit, :update, :destroy]

    def index
      @factory_taxons = FactoryTaxon.page(params[:page])
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
