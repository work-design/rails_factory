module Factory
  class Admin::ProductTaxonsController < Admin::BaseController
    before_action :set_product_taxon, only: [
      :show, :productions, :edit, :update, :reorder, :destroy,
      :import, :copy, :prune
    ]
    before_action :set_factory_taxons, only: [:new, :edit]
    before_action :set_scenes, only: [:new, :edit]
    before_action :set_products, only: [:import]
    before_action :set_new_product_taxon, only: [:new, :create]
    before_action :set_product_taxons, only: [:new, :create]
    before_action :set_own_product_taxons, only: [:edit, :update]
    before_action :set_production, only: [:copy, :prune]
    before_action :set_providers, only: [:import, :productions]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:name)

      product_taxons = ProductTaxon.includes(:factory_taxon).default_where(q_params).order(position: :asc).page(params[:page])
      @product_taxons = product_taxons.group_by(&:factory_taxon)
    end

    def all
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:name)

      @product_taxons = ProductTaxon.default_where(q_params).order(position: :asc)
      @factory_taxons = FactoryTaxon.where.not(id: @product_taxons.pluck(:factory_taxon_id)).order(position: :asc)
    end

    def import
      q_params = {
        organ_id: @product_taxon.provider_ids
      }
      q_params.merge! params.permit(:organ_id) if @product_taxon.provider_ids.map(&:to_s).include? params[:organ_id]
      if @product_taxon.factory_taxon
        @products = @product_taxon.factory_taxon.products.default_where(q_params).page(params[:page])
      else
        @products = Product.default_where(q_params).page(params[:page])
      end

      product_ids = @products.pluck(:id)
      @select_ids = ProductionProvide.default_where(default_params).where(upstream_product_id: product_ids).pluck(:upstream_product_id)
      @imported_production_ids = ProductionProvide.default_where(default_params).distinct(:upstream_production_id).pluck(:upstream_production_id)
    end

    def copy
      downstream_provide = @production.downstream_provides.find_or_initialize_by(organ_id: current_organ.id)
      downstream_provide.sync_from_upstream(@product_taxon)
      downstream_provide.save
    end

    def prune
      production = @production.downstream_provides.find_by(organ_id: current_organ.id)
      production.destroy
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
      if @product_taxon.factory_taxon
        @product_taxons = @product_taxon.factory_taxon.product_taxons.default_where(default_params)
      else
        @product_taxons = ProductTaxon.none
      end
    end

    def set_scenes
      @scenes = Scene.all.limit(10)
    end

    def set_products
      q_params = {}
      q_params.merge! params.permit(:organ_id)

      if @product_taxon.factory_taxon
        @products = @product_taxon.factory_taxon.products.default_where(q_params).page(params[:page])
      else
        @products = Product.default_where(q_params).page(params[:page])
      end

      product_ids = @products.pluck(:id)
      @select_ids = ProductionProvide.default_where(default_params).where(product_id: product_ids).pluck(:product_id)
    end

    def set_production
      @production = Production.where(organ_id: @product_taxon.provider_ids).find params[:production_id]
    end

    def set_providers
      if @product_taxon.factory_taxon
        @providers = @product_taxon.factory_taxon.providers
      else
        @providers = current_organ.providers
      end
    end

    def product_taxon_params
      p = params.fetch(:product_taxon, {}).permit(
        :name,
        :position,
        :logo,
        :logo_color,
        :parent_id,
        :parent_ancestors,
        :enabled,
        :partial,
        :nav,
        :factory_taxon_id,
        :scene_id
      )
      p.merge! default_form_params
    end

  end
end
