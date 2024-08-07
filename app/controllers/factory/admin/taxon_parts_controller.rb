module Factory
  class Admin::TaxonPartsController < Admin::BaseController
    before_action :set_taxon_component
    before_action :set_taxon_part, only: [:show, :edit, :update, :destroy]
    before_action :set_new_taxon_part, only: [:new, :create]

    def index
      @taxon_parts = @taxon_component.taxon_parts.order(part_id: :asc).page(params[:page])
    end

    private
    def set_taxon_component
      @taxon_component = TaxonComponent.find params[:taxon_component_id]
      @taxon = @taxon_component.taxon
    end

    def set_new_taxon_part
      @taxon_part = @taxon_component.taxon_parts.build(taxon_part_params)
    end

    def set_taxon_part
      @taxon_part = TaxonPart.find(params[:id])
    end

    def taxon_part_params
      params.fetch(:taxon_part, {}).permit(
        :part_id,
        :default
      )
    end

  end
end
