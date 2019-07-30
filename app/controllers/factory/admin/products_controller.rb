class Factory::Admin::ProductsController < Factory::Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]
  
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
    @product.assign_attributes(product_params)

    if @product.save
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
  
  def prepare_form
    @parts = Part.default_where(default_params)
  end

  def product_params
    p = params.fetch(:product, {}).permit(
      :name,
      :description,
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
