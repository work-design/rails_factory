module Factory
  class Admin::ProductsController < Admin::BaseController
    before_action :set_product, only: [:show, :edit, :actions, :part, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:product_taxon_id, :name)

      @products = Product.includes(:parts, :product_taxon, :product_part_taxons, logo_attachment: :blob, covers_attachments: :blob).default_where(q_params).order(product_taxon_id: :desc).page(params[:page])
    end

    def new
      @product = Product.new
      @product.product_taxon = ProductTaxon.default_where(default_params).new
    end

    def edit
      @product.product_taxon ||= ProductTaxon.default_where(default_params).first
    end

    private
    def set_product
      @product = Product.find(params[:id])
    end

    def set_brands
      @brands = Brand.default_where(default_params)
    end

    def product_params
      p = params.fetch(:product, {}).permit(
        :name,
        :description,
        :qr_prefix,
        :profit_margin,
        :logo,
        :specialty,
        :product_taxon_id,
        :product_taxon_ancestors,
        part_ids: [],
        covers: [],
        images: []
      )
      p.merge! default_form_params
    end

  end
end
