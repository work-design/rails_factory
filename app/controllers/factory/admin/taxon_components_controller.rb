module Factory
  class Admin::TaxonComponentsController < Admin::BaseController
    before_action :set_taxon
    before_action :set_new_taxon_component, only: [:new, :create]

    def index
      @product_part_taxons = @taxon.product_part_taxons.includes(:part_taxon, product_parts: :part).order(part_taxon_id: :asc).page(params[:page])
    end

    private
    def set_taxon
      @taxon = Taxon.find params[:taxon_id]
    end

    def set_new_taxon_component
      @taxon_component = @taxon.product_part_taxons.build(product_part_taxon_params)
    end
  end
end
