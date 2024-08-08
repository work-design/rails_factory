module Factory
  class Admin::ProductHostsController < Admin::BaseController
    before_action :set_brands, only: [:new, :create, :edit, :update]
    before_action :set_product, only: [:show, :edit, :actions, :part, :update, :destroy]
    before_action :set_new_product, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:taxon_id, :name)

      @product_hosts = ProductHost.includes(product: [:parts, :taxon, :brand, :product_part_taxons, logo_attachment: :blob, covers_attachments: :blob]).default_where(q_params).page(params[:page])
    end

    def new
      @product.product_hosts.build
      @product.taxon = Taxon.default_where(default_params).new
    end

    def edit
      @product.taxon ||= Taxon.default_where(default_params).first
    end

    private
    def set_product
      @product = Product.find(params[:id])
    end

    def set_new_product
      @product = Product.new(product_params)
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
        :taxon_id,
        :taxon_ancestors,
        part_ids: [],
        covers: [],
        images: [],
        product_hosts_attributes: {}
      )
      p.merge! default_form_params
    end

  end
end
