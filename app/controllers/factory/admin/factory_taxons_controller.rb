module Factory
  class Admin::FactoryTaxonsController < Admin::BaseController
    before_action :set_factory_taxon, only: [:show, :import, :productions, :edit, :update, :destroy]



    private
    def set_factory_taxon
      @factory_taxon = FactoryTaxon.find(params[:id])
    end

    def factory_taxon_params
      params.fetch(:factory_taxon, {}).permit(
        :name
      )
    end

  end
end
