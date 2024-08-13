module Factory
  class Admin::TaxonComponentsController < Admin::BaseController
    before_action :set_taxon
    before_action :set_new_taxon_component, only: [:new, :create]

    def index
      @taxon_components = @taxon.taxon_components.includes(:part_taxon, component_parts: :part).order(part_taxon_id: :asc).page(params[:page])
    end

    private
    def set_taxon
      @taxon = Taxon.find params[:taxon_id]
    end

    def set_new_taxon_component
      @taxon_component = @taxon.taxon_components.build(taxon_component_params)
    end

    def taxon_component_params
      params.fetch(:taxon_component, {}).permit(
        :min_select,
        :max_select,
        :part_taxon_id,
        :name,
        part_ids: []
      )
    end
  end
end
