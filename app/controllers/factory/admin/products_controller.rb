module Factory
  class Admin::ProductsController < Admin::BaseController
    before_action :set_product_taxon
    before_action :set_brands, only: [:new, :create, :edit, :update]
    before_action :set_product, only: [:show, :edit, :actions, :part, :update, :destroy]
    before_action :set_new_product, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:product_taxon_id, :name)

      @products = Product.includes(:parts, :product_taxon, :brand, :product_part_taxons, logo_attachment: :blob, covers_attachments: :blob).default_where(q_params).order(id: :asc).page(params[:page])
    end

    def new
      @product.product_hosts.build
      @product.product_taxon = ProductTaxon.default_where(default_params).new
    end

    def edit
      @product.product_taxon ||= ProductTaxon.default_where(default_params).first
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.default_where(default_params).find params[:product_taxon_id]
    end

    def set_product
      @product = Product.find(params[:id])
    end

    def set_new_product
      @product = @product_taxon.products.build(product_params)
    end

    def set_brands
      @brands = Brand.default_where(default_params)
    end

    def product_params
      p = params.fetch(:product, {}).permit(
        :name,
        :brand_id,
        :description,
        :qr_prefix,
        :profit_margin,
        :logo,
        :specialty,
        :product_taxon_id,
        :product_taxon_ancestors,
        part_ids: [],
        covers: [],
        images: [],
        product_hosts_attributes: {}
      )
      p.merge! default_form_params
    end

  end
end
