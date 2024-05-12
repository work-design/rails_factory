module Factory
  class Admin::ProductPartTaxonsController < Admin::BaseController
    before_action :set_product, if: -> { params[:product_id].present? }
    before_action :set_product_part_taxon, only: [:show, :edit, :update, :destroy]
    before_action :set_new_product_part_taxon, only: [:new, :create]
    before_action :set_part_taxons, only: [:new, :create, :edit, :update]

    def index
      @product_part_taxons = @product.product_part_taxons.includes(:part_taxon, product_parts: :part).order(part_taxon_id: :asc).page(params[:page])
    end

    private
    def set_product
      @product = Product.find params[:product_id]
    end

    def set_product_part_taxon
      @product_part_taxon = ProductPartTaxon.find(params[:id])
    end

    def set_new_product_part_taxon
      @product_part_taxon = @product.product_part_taxons.build(product_part_taxon_params)
    end

    def set_part_taxons
      @part_taxons = ProductTaxon.default_where(default_params).order(id: :asc)
    end

    def product_part_taxon_params
      params.fetch(:product_part_taxon, {}).permit(
        :min_select,
        :max_select,
        :part_taxon_id,
        :name,
        part_ids: []
      )
    end

  end
end
