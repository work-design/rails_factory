module Factory
  class TaxonsController < BaseController
    before_action :set_taxon, only: [:show]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit('name-like', :name)

      @taxons = Taxon.with_attached_logo.default_where(q_params).order(id: :asc).page(params[:page])
    end

    def show
    end

    private
    def set_taxon
      @taxon = Taxon.find(params[:id])
    end

  end
end
