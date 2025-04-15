module Factory
  class Admin::TaxonProvidesController < Admin::BaseController
    before_action :set_taxon
    before_action :set_taxon_provide, only: [:show, :edit, :update, :destroy, :refresh, :actions]
    before_action :set_new_taxon_provide, only: [:new, :create]

    def index
      q_params = {}

      @taxon_provides = @taxon.taxon_provides.default_where(q_params).order(id: :asc)
    end

    private
    def set_taxon
      @taxon = Taxon.default_where(default_params).find params[:taxon_id]
    end

    def set_taxon_provide
      @taxon_provide = @taxon.taxon_provides.find(params[:id])
    end

    def set_new_taxon_provide
      @taxon_provide = @taxon.taxon_provides.build(taxon_provide_params)
    end

    def taxon_provide_params
      params.fetch(:taxon_provide, {}).permit(
        :provide_id,
        :default,
      )
    end

  end
end
