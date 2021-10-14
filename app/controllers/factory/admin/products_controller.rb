module Factory
  class Admin::ProductsController < Admin::BaseController
    before_action :set_product, only: [:show, :edit, :part, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:product_taxon_id)

      @products = Product.includes(:parts, :product_taxon, logo_attachment: :blob, covers_attachments: :blob).default_where(q_params).order(id: :desc).page(params[:page])
    end

    def new
      @product = Product.new
      @product.product_taxon = ProductTaxon.default_where(default_params).new
    end

    def edit
      @product.product_taxon ||= ProductTaxon.default_where(default_params).first
    end

    def part
      @parts = Part.default_where(default_params)
    end

    private
    def set_product
      @product = Product.find(params[:id])
    end

    def product_params
      p = params.fetch(:product, {}).permit(
        :name,
        :description,
        :qr_prefix,
        :profit_margin,
        :logo,
        :product_taxon_ancestors,
        part_ids: [],
        covers: [],
        images: []
      )
      p.merge! default_form_params
    end

  end
end
