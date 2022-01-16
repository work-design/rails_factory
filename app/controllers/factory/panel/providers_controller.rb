module Factory
  class Panel::ProvidersController < Panel::BaseController
    before_action :set_factory_taxon
    before_action :set_provider, only: [:show, :edit, :update, :destroy]
    before_action :prepare_form

    def index
      @factory_providers = @factory_taxon.factory_providers.includes(:provider).page(params[:page])
    end

    def new
    end

    def create
      @factory_provider = @factory_taxon.factory_providers.build
      @factory_provider.provider_id = params[:provider_id]

      unless @factory_provider.save
        render :new, locals: { model: @factory_provider }, status: :unprocessable_entity
      end
    end

    def search
      @select_ids = @factory_taxon.provider_ids
      @providers = Org::Organ.default_where('name-like': params['name-like'])
    end

    private
    def set_factory_taxon
      @factory_taxon = FactoryTaxon.find params[:factory_taxon_id]
    end

    def set_provider
      @factory_provider = @factory_taxon.factory_providers.find(params[:id])
    end

    def prepare_form
      @providers = Org::Organ.none
    end

    def provider_params
      params.fetch(:provider, {}).permit(
      )
    end

  end
end
