module Factory
  class Admin::ProductPartTaxonsController < Admin::BaseController
    before_action :set_product
    before_action :set_product_part_taxon, only: [:show, :edit, :update, :destroy]
    before_action :set_remaining_part_taxons, only: [:new, :create]

    def index
      @product_part_taxons = @product.product_part_taxons.includes(:part_taxon, product_parts: :part).order(part_taxon_id: :asc).page(params[:page])
    end

    def new
      @product_part_taxon = @product.product_part_taxons.build
    end

    def create
      @product_part_taxon = @product.product_part_taxons.build(product_part_taxon_params)

      unless @product_part_taxon.save
        render :new, locals: { model: @product_part_taxon }, status: :unprocessable_entity
      end
    end

    private
    def set_product
      @product = Product.find params[:product_id]
    end

    def set_product_part_taxon
      @product_part_taxon = ProductPartTaxon.find(params[:id])
    end

    def set_remaining_part_taxons
      @part_taxons = PartTaxon.where.not(id: @product.part_taxon_ids).default_where(default_params).order(id: :asc)
    end

    def product_part_taxon_params
      params.fetch(:product_part_taxon, {}).permit(
        :min_select,
        :max_select,
        :part_taxon_id,
        part_ids: []
      )
    end

  end
end
