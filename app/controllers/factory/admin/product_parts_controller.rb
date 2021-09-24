module Factory
  class Admin::ProductPartsController < Admin::BaseController
    before_action :set_product
    before_action :set_product_part, only: [:show, :edit, :update, :destroy]

    def index
      @product_parts = @product.product_parts.order(part_id: :asc).page(params[:page])
    end

    def new
      @product_part = @product.product_parts.build
    end

    def create
      @product_part = ProductPart.new(product_part_params)

      unless @product_part.save
        render :new, locals: { model: @product_part }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @product_part.assign_attributes(product_part_params)

      unless @product_part.save
        render :edit, locals: { model: @product_part }, status: :unprocessable_entity
      end
    end

    def destroy
      @product_part.destroy
    end

    private
    def set_product
      @product = Product.find params[:product_id]
    end

    def set_product_part
      @product_part = ProductPart.find(params[:id])
    end

    def product_part_params
      params.fetch(:product_part, {}).permit(
        :part_id,
        :default
      )
    end

  end
end
