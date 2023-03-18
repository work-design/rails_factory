module Factory
  class In::ProvidesController < In::BaseController
    before_action :set_product_taxon
    before_action :set_new_provide, only: [:new, :create]

    def index
      @provides = @product_taxon.provides

      except_ids = @provides.pluck(:provider_id) << current_organ.id
      @providers = @product_taxon.factory_taxon.providers.where.not(id: except_ids).page(params[:page])
    end

    def add
      @provider = Org::Organ.find params[:provider_id]
      @provide = current_organ.provides.build(provider_id: params[:provider_id])
      @provide.product_taxon = @product_taxon
      @provide.save
    end

    def search
      @organs = Org::Organ.where.not(id: @product_taxon.provides.pluck(:provider_id)).default_where('name-like': params['name-like'])
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
        :provider_id
      )
    end

  end
end
