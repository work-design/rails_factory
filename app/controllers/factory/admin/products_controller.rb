class Factory::Admin::ProductsController < Factory::Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    @products = Product.includes(:parts).default_where(q_params).page(params[:page])
  end

  def new
    @product = Product.new
    @product.product_taxon = ProductTaxon.default_where(default_params).first
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to admin_products_url
    else
      render :new
    end
  end

  def show
  end

  def edit
    @product.product_taxon ||= ProductTaxon.default_where(default_params).first
  end

  def update
    if @product.update(product_params)
      redirect_to admin_products_url
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to admin_products_url
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    p = params.fetch(:product, {}).permit(
      :name,
      :qr_prefix,
      :reference_price,
      :logo,
      :main_image,
      :product_taxon_ancestors,
      part_ids: []
    )
    p.merge! default_params
  end

end
