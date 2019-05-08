class Factory::Admin::ProductsController < Factory::Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.includes(:parts).page(params[:page])
  end

  def new
    @product = Product.new
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
    params.fetch(:product, {}).permit(
      :name,
      :qr_prefix,
      :reference_price,
      :logo,
      :main_image,
      part_ids: []
    )
  end

end
