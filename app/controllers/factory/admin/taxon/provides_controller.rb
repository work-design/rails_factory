module Factory
  class Admin::Taxon::ProvidesController < Admin::ProvidesController
    before_action :set_taxon
    before_action :set_provide, only: [:show, :edit, :update, :destroy, :actions, :invite]
    before_action :set_new_taxon_provide, only: [:new]

    def index
      @taxon_provides = @taxon.taxon_provides.order(id: :asc)

      except_ids = @taxon_provides.pluck(:provide_id)
      @provides = Provide.where(default_params).where.not(id: except_ids).page(params[:page])
    end

    def providers
      @factory_providers = @taxon.factory_taxon.factory_providers.page(params[:page])
    end

    def search
      ids = @taxon.provides.pluck(:provider_id)
      ids.append current_organ.id
      @organs = Org::Organ.where.not(id: ids).default_where('name-like': params['name-like'])
    end

    private
    def set_taxon
      @taxon = Taxon.find params[:taxon_id]
    end

    def set_new_taxon_provide
      @provide.taxon_provides.build
    end

    def provide_params
      params.fetch(:provide, {}).permit(
        :provider_id,
        :name,
        taxon_provides_attributes: [:taxon_id]
      )
    end

  end
end
