module Factory
  class In::ProvidesController < In::BaseController
    before_action :set_product_taxon

    def index
      @providers = @product_taxon.factory_taxon.providers.page(params[:page])
      @provides = current_organ.provides
    end

    def search
      @organs = Org::Organ.default_where('name-like': params['name-like'])
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.find params[:product_taxon_id]
    end

  end
end
