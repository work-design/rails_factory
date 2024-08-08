module Factory
  class Admin::TaxonComponentsController < Admin::BaseController
    before_action :set_taxon
    before_action :set_new_taxon_component, only: [:new, :create]

    def index
      @taxon_components = @taxon.taxon_components.includes(:part_taxon, taxon_parts: :part).order(part_taxon_id: :asc).page(params[:page])
    end

    private
    def set_taxon
      @taxon = Taxon.find params[:taxon_id]
    end

    def set_new_taxon_component
      @taxon_component = @taxon.taxon_components.build(taxon_component_params)
    end
  end
end
