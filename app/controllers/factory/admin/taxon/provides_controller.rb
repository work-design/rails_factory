module Factory
  class Admin::Taxon::ProvidesController < Admin::ProvidesController
    before_action :set_product_taxon
    before_action :set_new_provide, only: [:new, :create]

    def index
      @provides = @product_taxon.provides

      except_ids = @provides.pluck(:provider_id) << current_organ.id
      if @product_taxon.factory_taxon
        @providers = @product_taxon.factory_taxon.providers.where.not(id: except_ids).page(params[:page])
      else
        @providers = current_organ.providers.where.not(id: except_ids).page(params[:page])
      end
    end

    def search
      ids = @product_taxon.provides.pluck(:provider_id)
      ids.append current_organ.id
      @organs = Org::Organ.where.not(id: ids).default_where('name-like': params['name-like'])
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.find params[:product_taxon_id]
    end

    def set_new_provide
      @provide = @product_taxon.provides.build(provide_params)
    end

    def provide_params
      params.fetch(:provide, {}).permit(
        :provider_id,
        :name
      )
    end

  end
end
