class Factory::Admin::PartTaxonsController < Factory::Admin::BaseController
  before_action :set_part_taxon, only: [:show, :import, :productions, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:name)

    @part_taxons = PartTaxon.roots.default_where(q_params).page(params[:page])
  end

  def new
    @part_taxon = PartTaxon.new default_form_params
  end

  def create
    @part_taxon = PartTaxon.new(part_taxon_params)

    unless @part_taxon.save
      render :new, locals: { model: @part_taxon }, status: :unprocessable_entity
    end
  end

  def show
  end

  def import
    @products = @part_taxon.factory_taxon.products.page(params[:page])

    q_params = {}
    q_params.merge! 'part.organ_id': current_organ.id if current_organ

    product_ids = @products.pluck(:id)
    @select_ids = PartProvider.default_where(q_params).where(product_id: product_ids).pluck(:product_id)
  end

  def productions
    @productions = Production.default_where(product_id: params[:product_id])
  end

  def edit
  end

  def update
    @part_taxon.assign_attributes(part_taxon_params)

    unless @part_taxon.save
      render :edit, locals: { model: @part_taxon }, status: :unprocessable_entity
    end
  end

  def destroy
    @part_taxon.destroy
  end

  private
  def set_part_taxon
    @part_taxon = PartTaxon.find(params[:id])
  end

  def part_taxon_params
    p = params.fetch(:part_taxon, {}).permit(
      :name,
      :position,
      :parent_id,
      :parent_ancestors,
      :factory_taxon_id,
      :product_taxon_ancestors
    )
    p.merge! default_form_params
  end

end
