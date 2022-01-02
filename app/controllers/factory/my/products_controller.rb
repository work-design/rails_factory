module Factory
  class My::ProductsController < My::BaseController
    before_action :set_product, only: [:show, :edit, :update, :destroy]

    def index
      @products = Product.page(params[:page])
    end

    def show
      @custom = current_cart.customs.find_or_initialize_by(product_id: @product.id)
    end

    def update_price
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
end
