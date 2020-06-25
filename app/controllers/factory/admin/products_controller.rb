class Factory::Admin::ProductsController < Factory::Admin::BaseController
  before_action :set_product, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  def index
    q_params = {}
    q_params.merge! default_params
    @products = Product.includes(:parts).default_where(q_params).page(params[:page])
  end

  def new
    @product = Product.new
    @product.product_taxon = ProductTaxon.default_where(default_params).first
  end

  def create
    @product = Product.new(product_params)

    unless @product.save
      render :new, locals: { model: @product }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
    @product.product_taxon ||= ProductTaxon.default_where(default_params).first
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
    @parts = Part.default_where(default_params)
  end

  def product_params
    p = params.fetch(:product, {}).permit(
      :name,
      :description,
      :qr_prefix,
      :reference_price,
      :logo,
      :product_taxon_ancestors,
      part_ids: [],
      covers: [],
      images: []
    )
    p.merge! default_form_params
  end

end
