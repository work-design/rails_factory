module Factory
  class Admin::ProductsController < Admin::BaseController
    before_action :set_brands, only: [:new, :create, :edit, :update]
    before_action :set_product, only: [:show, :edit, :update, :destroy, :reorder, :actions, :part]
    before_action :set_new_product, only: [:new, :create]
    before_action :set_product_taxons, only: [:index, :edit, :update]
    before_action :set_cart, only: [:buy]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:product_taxon_id)

      @products = Product.includes(:product_taxon, :productions, logo_attachment: :blob, covers_attachments: :blob).default_where(q_params).page(params[:page])
    end

    def buy
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:product_taxon_id, :name)

      @products = Product.includes(:brand, productions: { upstream_provides: :provider }, logo_attachment: :blob, covers_attachments: :blob).default_where(q_params).order(position: :asc).page(params[:page])
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

    def set_product_taxons
      @product_taxons = ProductTaxon.default_where(default_params)
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

    def set_cart
      options = {
        member_organ_id: current_organ.id,
        purchasable: true
      }

      options.merge! user_id: nil, member_id: nil
      options.merge! client_id: nil, contact_id: nil if defined? RailsCrm
      @cart = Trade::Cart.where(options).find_or_create_by(good_type: 'Factory::Production', aim: 'use')
      @cart.compute_amount! unless @cart.fresh
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
