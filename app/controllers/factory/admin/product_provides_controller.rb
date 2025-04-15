module Factory
  class Admin::ProductProvidesController < Admin::BaseController
    before_action :set_product
    before_action :set_product_provide, only: [:show, :edit, :update, :destroy]
    before_action :set_new_product_provide, only: [:new, :create]

    def index
      q_params = {}

      @product_provides = @product.product_provides.default_where(q_params).order(id: :asc)
      #@provides = Provide.where(default_params).where.not(id: @production_provides.pluck(:provide_id))
    end

    private
    def set_product
      @product = Product.find params[:product_id]
    end

    def set_product_provide
      @product_provide = @product.product_provides.find(params[:id])
    end

    def set_new_product_provide
      @product_provide = @product.product_provides.build(product_provide_params)
    end

    def product_provide_params
      params.fetch(:product_provide, {}).permit(
        :provide_id,
        :default
      )
    end

  end
end
