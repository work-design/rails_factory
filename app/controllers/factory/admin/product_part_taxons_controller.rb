class Factory::Admin::ProductPartTaxonsController < Factory::Admin::BaseController
  before_action :set_product
  before_action :set_product_part_taxon, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  def index
    @product_part_taxons = @product.product_part_taxons.includes(:part_taxon).page(params[:page])
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

  def show
  end

  def edit
  end

  def update
    @product_part_taxon.assign_attributes(product_part_taxon_params)

    unless @product_part_taxon.save
      render :edit, locals: { model: @product_part_taxon }, status: :unprocessable_entity
    end
  end

  def destroy
    @product_part_taxon.destroy
  end

  private
  def set_product
    @product = Product.find params[:product_id]
  end

  def set_product_part_taxon
    @product_part_taxon = ProductPartTaxon.find(params[:id])
  end

  def prepare_form
    @part_taxons = PartTaxon.roots.default_where(default_params)
  end

  def product_part_taxon_params
    params.fetch(:product_part_taxon, {}).permit(
      :name,
      :min_select,
      :max_select,
      :part_taxon_ancestors
    )
  end

end
