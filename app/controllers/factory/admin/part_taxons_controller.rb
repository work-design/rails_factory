class Factory::Admin::PartTaxonsController < Factory::Admin::BaseController
  before_action :set_part_taxon, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:name)
    @part_taxons = PartTaxon.roots.default_where(q_params).page(params[:page])
  end

  def new
    @part_taxon = PartTaxon.new
  end

  def create
    @part_taxon = PartTaxon.new(part_taxon_params)

    if @part_taxon.save
      redirect_to admin_part_taxons_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @part_taxon.update(part_taxon_params)
      redirect_to admin_part_taxons_url
    else
      render :edit
    end
  end

  def destroy
    @part_taxon.destroy
    redirect_to admin_part_taxons_url
  end

  private
  def set_part_taxon
    @part_taxon = PartTaxon.find(params[:id])
  end

  def part_taxon_params
    p = params.fetch(:part_taxon, {}).permit(
      :name,
      :position,
      :min_select,
      :max_select,
      :parent_id,
      :parent_ancestors
    )
    p.merge! default_form_params
  end

end
