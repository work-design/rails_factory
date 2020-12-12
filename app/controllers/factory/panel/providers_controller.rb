class Factory::Panel::ProvidersController < Factory::Panel::BaseController
  before_action :set_part_taxon_template
  before_action :set_provider, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form

  def index
    @part_taxon_providers = @part_taxon_template.part_taxon_providers.includes(:provider).page(params[:page])
  end

  def new
  end

  def create
    @part_taxon_provider = @part_taxon_template.part_taxon_providers.build
    @part_taxon_provider.provider_id = params[:provider_id]

    unless @part_taxon_provider.save
      render :new, locals: { model: @part_taxon_provider }, status: :unprocessable_entity
    end
  end

  def search
    @select_ids = @part_taxon_template.provider_ids
    @providers = Organ.default_where('name-like': params['name-like'])
  end

  def show
  end

  def edit
  end

  def update
    @part_taxon_provider.assign_attributes(provider_params)

    unless @part_taxon_provider.save
      render :edit, locals: { model: @part_taxon_provider }, status: :unprocessable_entity
    end
  end

  def destroy
    @part_taxon_provider.destroy
  end

  private
  def set_part_taxon_template
    @part_taxon_template = PartTaxonTemplate.find params[:part_taxon_template_id]
  end

  def set_provider
    @part_taxon_provider = @part_taxon_template.part_taxon_providers.find(params[:id])
  end

  def prepare_form
    @providers = Organ.none
  end

  def provider_params
    params.fetch(:provider, {}).permit(
    )
  end

end
