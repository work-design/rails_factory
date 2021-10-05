module Factory
  class ProductPlansController < BaseController
    before_action :set_product
    before_action :set_product_plan, only: [:show]

    def index
      @product_plans = @product.product_plans.page(params[:page])
    end

    private
    def set_product
      @product = Product.find params[:product_id]
    end

    def set_product_plan
      @product_plan = ProductPlan.find(params[:id])
    end

  end
end
