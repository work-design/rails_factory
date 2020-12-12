class Factory::Admin::ProductTaxonsController < Factory::Admin::BaseController
  before_action :set_product_taxon, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    @product_taxons = ProductTaxon.default_where(q_params).order(id: :asc).page(params[:page])
  end

  def new
    @product_taxon = ProductTaxon.new(default_form_params)
  end

  def create
    @product_taxon = ProductTaxon.new(product_taxon_params)

    unless @product_taxon.save
      render :new, locals: { model: @product_taxon }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @product_taxon.assign_attributes(product_taxon_params)

    unless @product_taxon.save
      render :edit, locals: { model: @product_taxon }, status: :unprocessable_entity
    end
  end

  def destroy
    @product_taxon.destroy
  end

  private
  def set_product_taxon
    @product_taxon = ProductTaxon.find(params[:id])
  end

  def product_taxon_params
    p = params.fetch(:product_taxon, {}).permit(
      :name,
      :position,
      :logo,
      :parent_id,
      :factory_taxon_id,
      :parent_ancestors
    )
    p.merge! default_form_params
  end

end
