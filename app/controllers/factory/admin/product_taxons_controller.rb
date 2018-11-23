class Factory::Admin::ProductTaxonsController < Factory::Admin::BaseController
  before_action :set_product_taxon, only: [:show, :edit, :update, :destroy]

  def index
    @product_taxons = ProductTaxon.page(params[:page])
  end

  def new
    @product_taxon = ProductTaxon.new
  end

  def create
    @product_taxon = ProductTaxon.new(product_taxon_params)

    if @product_taxon.save
      redirect_to admin_product_taxons_url, notice: 'Product taxon was successfully created.'
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
      redirect_to admin_product_taxons_url, notice: 'Product taxon was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product_taxon.destroy
    redirect_to admin_product_taxons_url, notice: 'Product taxon was successfully destroyed.'
  end

  private
  def set_product_taxon
    @product_taxon = ProductTaxon.find(params[:id])
  end

  def product_taxon_params
    params.fetch(:product_taxon, {}).permit(
      :name,
      :position,
      :profit_margin,
      :parent_id,
      :parent_ancestors
    )
  end

end
