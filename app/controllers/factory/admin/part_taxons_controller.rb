module Factory
  class Admin::PartTaxonsController < Admin::BaseController

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:name)

      @part_taxons = PartTaxon.default_where(q_params).order(id: :asc).page(params[:page])
    end


    private
    def set_part_taxon
      @part_taxon = PartTaxon.find(params[:id])
    end

    def part_taxon_params
      p = params.fetch(:part_taxon, {}).permit(
        :name,
        :position,
        :parent_id,
        :parent_ancestors,
        :factory_taxon_id,
        :product_taxon_ancestors
      )
      p.merge! default_form_params
    end

  end
end
