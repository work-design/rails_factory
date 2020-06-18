class Factory::ProductsController < Factory::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:product_taxon_id)
    @products = Product.default_where(q_params).page(params[:page])
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
