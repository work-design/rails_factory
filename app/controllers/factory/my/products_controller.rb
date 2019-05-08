class Factory::My::ProductsController < Factory::My::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.page(params[:page])
  end

  def new
    @product = Product.new
  end

  def create
    @product = Product.new(product_params)

    if @product.save
      redirect_to wx_products_url
    else
      render :new
    end
  end

  def show
    @custom = @product.customs.build
  end

  def update_price

  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to wx_products_url
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to wx_products_url
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def product_params
    params.fetch(:product, {}).permit(
    )
  end

end
