class Factory::ProductsController < Factory::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    @products = Product.page(params[:page])
  end

  def show
    @custom = @product.customs.build
  end

  def edit
  end

  def update
    if @product.update(product_params)
      redirect_to products_url
    else
      render :edit
    end
  end

  def destroy
    @product.destroy
    redirect_to products_url
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
