module Factory
  class Admin::ProducePlansController < Admin::BaseController
    before_action :set_scene
    before_action :set_produce_plan, only: [:show, :products, :edit, :update, :destroy]
    before_action :set_new_produce_plan, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:title)

      @produce_plans = @scene.produce_plans.default_where(q_params).order(produce_on: :desc).page(params[:page])
    end

    def products
      @product_taxons = @produce_plan.scene.product_taxons
      @production_plans = @produce_plan.production_plans
      q_params = {
        product_taxon_id: @product_taxons.map(&:id)
      }
      q_params.merge! default_params
      q_params.merge! params.permit(:product_taxon_id)

      @products = Product.includes(:productions, :product_taxon, logo_attachment: :blob).default_where(q_params).order(product_taxon_id: :desc).page(params[:page])
    end

    private
    def set_scene
      @scene = Scene.find params[:scene_id]
    end

    def set_new_produce_plan
      @produce_plan = @scene.produce_plans.build(produce_plan_params)
    end

    def set_produce_plan
      @produce_plan = @scene.produce_plans.find params[:id]
    end

    def produce_plan_params
      params.fetch(:produce_plan, {}).permit(
        :scene_id,
        :produce_on,
        :state
      )
    end

  end
end
