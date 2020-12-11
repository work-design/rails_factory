class Factory::Panel::PartTaxonTemplatesController < Factory::Panel::BaseController
  before_action :set_part_taxon_template, only: [:show, :edit, :update, :destroy]

  def index
    @part_taxon_templates = PartTaxonTemplate.page(params[:page])
  end

  def new
    @part_taxon_template = PartTaxonTemplate.new
  end

  def create
    @part_taxon_template = PartTaxonTemplate.new(part_taxon_template_params)

    unless @part_taxon_template.save
      render :new, locals: { model: @part_taxon_template }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @part_taxon_template.assign_attributes(part_taxon_template_params)

    unless @part_taxon_template.save
      render :edit, locals: { model: @part_taxon_template }, status: :unprocessable_entity
    end
  end

  def destroy
    @part_taxon_template.destroy
  end

  private
  def set_part_taxon_template
    @part_taxon_template = PartTaxonTemplate.find(params[:id])
  end

  def part_taxon_template_params
    params.fetch(:part_taxon_template, {}).permit(
      :name
    )
  end

end
