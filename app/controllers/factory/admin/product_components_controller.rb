module Factory
  class Admin::ProductComponentsController < Admin::BaseController
    before_action :set_product
    before_action :set_product_component, only: [:show, :edit, :update, :destroy]
    before_action :set_new_product_component, only: [:new, :create]
    before_action :set_part_taxons, only: [:new, :create, :edit, :update]

    def index
      @product_components = @product.product_components.includes(:part_taxon, product_parts: :part).order(part_taxon_id: :asc).page(params[:page])
    end

    private
    def set_product
      @product = Product.find params[:product_id]
    end

    def set_product_component
      @product_component = @product.product_components.find(params[:id])
    end

    def set_new_product_component
      @product_component = @product.product_components.build(product_component_params)
    end

    def set_part_taxons
      @part_taxons = Taxon.default_where(default_params).order(id: :asc)
    end

    def product_component_params
      params.fetch(:product_component, {}).permit(
        :min_select,
        :max_select,
        :part_taxon_id,
        :name,
        part_ids: []
      )
    end

  end
end
