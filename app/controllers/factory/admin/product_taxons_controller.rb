class Factory::Admin::ProductTaxonsController < Factory::Admin::BaseController
  before_action :set_product_taxon, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    @product_taxons = ProductTaxon.default_where(q_params).page(params[:page])
  end

  def new
    @product_taxon = ProductTaxon.new
  end

  def create
    @product_taxon = ProductTaxon.new(product_taxon_params)

    if @product_taxon.save
      redirect_to admin_product_taxons_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product_taxon.update(product_taxon_params)
      redirect_to admin_product_taxons_url
    else
      render :edit
    end
  end

  def destroy
    @product_taxon.destroy
    redirect_to admin_product_taxons_url
  end

  private
  def set_product_taxon
    @product_taxon = ProductTaxon.find(params[:id])
  end

  def product_taxon_params
    p = params.fetch(:product_taxon, {}).permit(
      :name,
      :position,
      :profit_margin,
      :parent_id,
      :parent_ancestors
    )
    p.merge! default_form_params
  end

end
