module Factory
  class Admin::Taxon::ProductPartTaxonsController < Admin::ProductPartTaxonsController
    before_action :set_product_taxon
    before_action :set_new_product_part_taxon, only: [:new, :create]


    def index
      @product_part_taxons = @product_taxon.product_part_taxons.includes(:part_taxon, product_parts: :part).order(part_taxon_id: :asc).page(params[:page])
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.find params[:product_taxon_id]
    end

    def set_new_product_part_taxon
      @product_part_taxon = @product_taxon.product_part_taxons.build(product_part_taxon_params)
    end
  end
end
