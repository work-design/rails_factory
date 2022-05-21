module Factory
  class Panel::FactoryProvidersController < Panel::BaseController
    before_action :set_factory_taxon
    before_action :set_factory_provider, only: [:show, :edit, :update, :destroy]

    def index
      @factory_providers = @factory_taxon.factory_providers.includes(:provider).page(params[:page])
    end

    def new
      @factory_provider = @factory_taxon.factory_providers.build
    end

    def create
      @factory_provider = @factory_taxon.factory_providers.build(factory_provider_params)

      unless @factory_provider.save
        render :new, locals: { model: @factory_provider }, status: :unprocessable_entity
      end
    end

    def search
      @select_ids = @factory_taxon.provider_ids
      @organs = Org::Organ.default_where('name-like': params['name-like'])
    end

    private
    def set_factory_taxon
      @factory_taxon = FactoryTaxon.find params[:factory_taxon_id]
    end

    def set_factory_provider
      @factory_provider = @factory_taxon.factory_providers.find(params[:id])
    end

    def factory_provider_params
      params.fetch(:factory_provider, {}).permit(
        :provider_id
      )
    end

  end
end
