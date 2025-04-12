module Factory
  class Admin::TaxonProvidesController < Admin::BaseController
    before_action :set_provide
    before_action :set_taxon_provide, only: [:show, :edit, :update, :destroy]
    before_action :set_new_taxon_provide, only: [:new, :create]

    def index
      q_params = {}

      @production_provides = @production.production_provides.default_where(q_params).order(id: :asc)
      @provides = Provide.where(default_params).where.not(id: @production_provides.pluck(:provide_id))
    end

    private
    def set_provide
      @provide = Provide.find params[:provide_id]
    end

    def set_taxon_provide
      @taxon_provide = @provide.taxon_provides.find(params[:id])
    end

    def set_new_taxon_provide
      @taxon_provide = @provide.taxon_provides.build(taxon_provide_params)
    end

    def taxon_provide_params
      params.fetch(:taxon_provide, {}).permit(
        :taxon_id,
        :default,
      )
    end

  end
end
