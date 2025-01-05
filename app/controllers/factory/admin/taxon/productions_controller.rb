module Factory
  class Admin::Taxon::ProductionsController < Admin::ProductionsController
    before_action :set_taxon
    before_action :set_taxons, only: [:index, :edit, :update]

    def index
      @productions = @taxon.productions.includes(
        :product,
        production_parts: :part,
        logo_attachment: :blob
      ).default.order(id: :asc).page(params[:page])
    end

    private
    def set_taxon
      @taxon = Taxon.default_where(default_params).find params[:taxon_id]
    end

    def set_taxons
      @taxons = Taxon.default_where(default_params)
    end

  end
end
