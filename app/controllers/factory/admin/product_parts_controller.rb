module Factory
  class Admin::ProductPartsController < Admin::BaseController
    before_action :set_product
    before_action :set_product_part_taxon
    before_action :set_product_part, only: [:show, :edit, :update, :destroy]

    def index
      @product_parts = @product_part_taxon.product_parts.order(part_id: :asc).page(params[:page])
    end

    private
    def set_product
      @product = Product.find params[:product_id]
    end

    def set_product_part_taxon
      @product_part_taxon = @product.product_part_taxons.find params[:product_part_taxon_id]
    end

    def set_new_product_part
      @product_part = @product.product_parts.build(product_part_params)
    end

    def set_product_part
      @product_part = ProductPart.find(params[:id])
    end

    def product_part_params
      params.fetch(:product_part, {}).permit(
        :min_select,
        :max_select,
        :part_id,
        :name,
        :default
      )
    end

  end
end
