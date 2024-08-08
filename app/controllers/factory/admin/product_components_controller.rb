module Factory
  class Admin::ProductComponentsController < Admin::BaseController
    before_action :set_product, if: -> { params[:product_id].present? }
    before_action :set_taxon_component, only: [:show, :edit, :update, :destroy]
    before_action :set_new_taxon_component, only: [:new, :create]
    before_action :set_part_taxons, only: [:new, :create, :edit, :update]

    def index
      @taxon_components = @product.taxon_components.includes(:part_taxon, product_parts: :part).order(part_taxon_id: :asc).page(params[:page])
    end

    private
    def set_product
      @product = Product.find params[:product_id]
    end

    def set_taxon_component
      @taxon_component = ProductPartTaxon.find(params[:id])
    end

    def set_new_taxon_component
      @taxon_component = @product.taxon_components.build(taxon_component_params)
    end

    def set_part_taxons
      @part_taxons = Taxon.default_where(default_params).order(id: :asc)
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
