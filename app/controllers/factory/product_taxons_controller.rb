module Factory
  class ProductTaxonsController < BaseController
    before_action :set_product_taxon, only: [:show]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit('name-like', :name)

      @product_taxons = ProductTaxon.with_attached_logo.default_where(q_params).order(id: :asc).page(params[:page])
    end

    def show
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.find(params[:id])
    end

  end
end
