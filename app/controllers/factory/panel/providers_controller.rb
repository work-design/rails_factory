class Factory::Panel::ProvidersController < Factory::Panel::BaseController
  before_action :set_part_taxon_template
  before_action :set_provider, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form

  def index
    @providers = @part_taxon_template.providers.page(params[:page])
  end

  def new
    @provider = @part_taxon_template.providers.build
  end

  def create
    @provider = Provider.new(provider_params)

    unless @provider.save
      render :new, locals: { model: @provider }, status: :unprocessable_entity
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
    @provider.assign_attributes(provider_params)

    unless @provider.save
      render :edit, locals: { model: @provider }, status: :unprocessable_entity
    end
  end

  def destroy
    @provider.destroy
  end

  private
  def set_part_taxon_template
    @part_taxon_template = PartTaxonTemplate.find params[:part_taxon_template_id]
  end

  def set_provider
    @provider = Provider.find(params[:id])
  end

  def prepare_form
    @providers = Organ.none
  end

  def provider_params
    params.fetch(:provider, {}).permit(
    )
  end

end
