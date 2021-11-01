module Factory
  class Admin::ProductTaxonsController < Admin::BaseController
    before_action :set_product_taxon, only: [:show, :edit, :update, :reorder, :destroy]
    before_action :set_factory_taxons, only: [:new, :edit]
    before_action :set_scenes, only: [:new, :edit]

    def index
      q_params = {}
      q_params.merge! default_params

      @product_taxons = ProductTaxon.default_where(q_params).order(position: :asc).page(params[:page])
    end

    def new
      @product_taxon = ProductTaxon.new(default_form_params)
    end

    def create
      @product_taxon = ProductTaxon.new(product_taxon_params)

      unless @product_taxon.save
        render :new, locals: { model: @product_taxon }, status: :unprocessable_entity
      end
    end

    def reorder
      sort_array = params[:sort_array].select { |i| i.integer? }

      if params[:new_index] > params[:old_index]
        prev_one = @product_taxon.class.find(sort_array[params[:new_index].to_i - 1])
        @product_taxon.insert_at prev_one.position
      else
        next_ones = @product_taxon.class.find(sort_array[(params[:new_index].to_i + 1)..params[:old_index].to_i])
        next_ones.each do |next_one|
          next_one.insert_at @product_taxon.position
        end
      end
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.find(params[:id])
    end

    def set_factory_taxons
      @factory_taxons = FactoryTaxon.all
    end

    def set_scenes
      @scenes = Scene.default_where(default_params)
    end

    def product_taxon_params
      p = params.fetch(:product_taxon, {}).permit(
        :name,
        :position,
        :logo,
        :parent_id,
        :enabled,
        :factory_taxon_id,
        :scene_id,
        :parent_ancestors
      )
      p.merge! default_form_params
    end

  end
end
