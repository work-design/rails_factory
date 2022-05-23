module Factory
  class Admin::PartProvidersController < Admin::BaseController
    before_action :set_production
    before_action :set_part_provider, only: [:show, :edit, :update, :destroy]
    before_action :set_providers, only: [:index]

    def index
      q_params = {}
      q_params.merge! params.permit(:good_type, :good_id)

      @part_providers = @production.part_providers.default_where(q_params).order(id: :asc).page(params[:page])
    end

    def new
      @part_provider = @production.part_providers.build
    end

    def create
      @part_provider = @production.part_providers.build(part_provider_params)

      unless @part_provider.save
        render :new, locals: { model: @part_provider }, status: :unprocessable_entity
      end
    end

    def search
      q_params = {}
      q_params.merge! params.permit('name-like', :organ_id)

      @productions = Production.default_where(q_params)
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_part_provider
      @part_provider = @production.part_providers.find(params[:id])
    end

    def set_providers
      @providers = @production.product_taxon.factory_taxon.providers
    end

    def part_provider_params
      params.fetch(:part_provider, {}).permit(
        :verified,
        :selected,
        :provider_id,
        :upstream_product_id,
        :upstream_production_id
      )
    end

  end
end
