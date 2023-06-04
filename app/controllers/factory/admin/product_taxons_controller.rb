module Factory
  class Admin::ProductTaxonsController < Admin::BaseController
    before_action :set_product_taxon, only: [:show, :import, :productions, :edit, :update, :reorder, :destroy]
    before_action :set_factory_taxons, only: [:new, :edit]
    before_action :set_scenes, only: [:new, :edit]
    before_action :set_products, only: [:import]
    before_action :set_new_product_taxon, only: [:new, :create]
    before_action :set_product_taxons, only: [:new, :create]
    before_action :set_own_product_taxons, only: [:edit, :update]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:name)

      @product_taxons = ProductTaxon.default_where(q_params).order(position: :asc)
      @factory_taxons = FactoryTaxon.where.not(id: @product_taxons.pluck(:factory_taxon_id)).order(position: :asc)
    end

    def productions
      @productions = @product_taxon.productions.default.page(params[:page])
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.find(params[:id])
    end

    def set_factory_taxons
      @factory_taxons = FactoryTaxon.all.limit(10)
    end

    def set_factory_taxon
      @factory_taxon = FactoryTaxon.find params[:factory_taxon_id]
    end

    def set_new_product_taxon
      if params[:factory_taxon_id].present?
        @factory_taxon = FactoryTaxon.find params[:factory_taxon_id]
        @product_taxon = @factory_taxon.product_taxons.build(product_taxon_params)
        @product_taxon.scene_id = @factory_taxon.scene_id
      else
        @product_taxon = ProductTaxon.new(product_taxon_params)
      end
    end

    def set_product_taxons
      if params[:factory_taxon_id].present?
        @product_taxons = @factory_taxon.product_taxons.default_where(default_params)
      end
    end

    def set_own_product_taxons
      @product_taxons = @product_taxon.factory_taxon.product_taxons.default_where(default_params)
    end

    def set_scenes
      @scenes = Scene.all.limit(10)
    end

    def set_products
      q_params = {}
      q_params.merge! params.permit(:organ_id)
      @products = @product_taxon.factory_taxon.products.default_where(q_params).page(params[:page])

      product_ids = @products.pluck(:id)
      @select_ids = PartProvider.default_where(default_params).where(product_id: product_ids).pluck(:product_id)
    end

    def product_taxon_params
      p = params.fetch(:product_taxon, {}).permit(
        :name,
        :position,
        :logo,
        :parent_id,
        :parent_ancestors,
        :enabled,
        :partial,
        :factory_taxon_id,
        :scene_id
      )
      p.merge! default_form_params
    end

  end
end
