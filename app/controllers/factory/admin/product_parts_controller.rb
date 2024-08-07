module Factory
  class Admin::ProductPartsController < Admin::BaseController
    before_action :set_product_part_taxon
    before_action :set_product_part, only: [:show, :edit, :update, :destroy]
    before_action :set_new_product_part, only: [:new, :create]

    def index
      @product_parts = @product_part_taxon.product_parts.order(part_id: :asc).page(params[:page])
    end

    private
    def set_product_part_taxon
      @product_part_taxon = ProductPartTaxon.find params[:product_part_taxon_id]
      @taxon = @product_part_taxon.taxon
    end

    def set_new_product_part
      @product_part = @product_part_taxon.product_parts.build(product_part_params)
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
