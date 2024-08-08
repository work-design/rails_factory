module Factory
  class Admin::Taxon::ProvidesController < Admin::ProvidesController
    before_action :set_taxon
    before_action :set_provide, only: [:show, :edit, :update, :destroy, :actions, :invite]
    before_action :set_new_provide, only: [:new, :create]

    def index
      @provides = @taxon.provides

      except_ids = @provides.pluck(:provider_id) << current_organ.id
      if @taxon.factory_taxon
        @providers = @taxon.factory_taxon.providers.where.not(id: except_ids).page(params[:page])
      else
        @providers = current_organ.providers.where.not(id: except_ids).page(params[:page])
      end
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

    def set_provide
      @provide = @taxon.provides.find params[:id]
    end

    def set_new_provide
      @provide = @taxon.provides.build(provide_params)
    end

    def provide_params
      params.fetch(:provide, {}).permit(
        :provider_id,
        :name
      )
    end

  end
end
