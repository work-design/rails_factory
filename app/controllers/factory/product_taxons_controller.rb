class Factory::ProductTaxonsController < Factory::BaseController
  before_action :set_product_taxon, only: [:show]

  def index
    q_params = {}
    q_params.merge! default_params
    @product_taxons = ProductTaxon.default_where(q_params).order(id: :asc).page(params[:page])
  end

  def show
  end

  private
  def set_product_taxon
    @product_taxon = ProductTaxon.find(params[:id])
  end

end
