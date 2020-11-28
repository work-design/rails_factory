class Factory::Admin::ProductsController < Factory::Admin::BaseController
  before_action :set_product, only: [:show, :edit, :part, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  def index
    q_params = {}
    q_params.merge! default_params
    @products = Product.includes(:parts).default_where(q_params).order(id: :desc).page(params[:page])
  end

  def new
    @product = Product.new
    @product.product_taxon = ProductTaxon.default_where(default_params).first
    @product.product_part_taxons.build
  end

  def create
    @product = Product.new(product_params)

    unless @product.save
      render :new, locals: { model: @product }, status: :unprocessable_entity
    end
  end

  def add_item
    @product = Product.new
    @product.product_part_taxons.build
  end

  def remove_item
  end

  def show
  end

  def edit
    @product.product_taxon ||= ProductTaxon.default_where(default_params).first
  end

  def part
    @parts = Part.default_where(default_params)
  end

  def update
    @product.assign_attributes(product_params)

    unless @product.save
      render :edit, locals: { model: @product }, status: :unprocessable_entity
    end
  end

  def destroy
    @product.destroy
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def prepare_form
    @part_taxons = PartTaxon.roots.default_where(default_params)
  end

  def product_params
    p = params.fetch(:product, {}).permit(
      :name,
      :description,
      :qr_prefix,
      :profit_margin,
      :logo,
      :product_taxon_ancestors,
      product_part_taxons_attributes: {},
      part_taxon_ids: [],
      part_ids: [],
      covers: [],
      images: []
    )
    p.merge! default_form_params
  end

end
