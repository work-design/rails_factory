module Factory
  class ProductsController < BaseController
    before_action :set_product_taxon
    before_action :set_product, only: [:show]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:product_taxon_id, 'name-like')

      @products = Product.default_where(q_params).page(params[:page])
    end

    def show
      if params[:production_id]
        @production = @product.productions.find params[:production_id]
      elsif pc = current_cart.production_carts.where(product_id: @product.id).order(customized_at: :desc).first
        @production = pc.production
      else
        @production = @product.production
      end
    end

    private
    def set_product
      @product = Product.find params[:id]
    end

    def set_product_taxon
      @product_taxon = ProductTaxon.find params[:product_taxon_id] if params[:product_taxon_id]
    end

  end
end
