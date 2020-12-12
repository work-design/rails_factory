class Factory::Admin::PartTaxonsController < Factory::Admin::BaseController
  before_action :set_part_taxon, only: [:show, :edit, :update, :destroy]

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
      :part_taxon_template_id,
      :product_taxon_ancestors
    )
    p.merge! default_form_params
  end

end
