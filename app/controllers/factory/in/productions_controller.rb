module Factory
  class In::ProductionsController < ProductionsController
    include Trade::Controller::Me
    include Controller::Buy
    before_action :set_product_taxon
    before_action :set_produce_plans, only: [:index, :plan]
    before_action :set_product_taxons, only: [:index]
    before_action :set_product, only: [:show]
    before_action :set_card_templates, only: [:index]
    before_action :set_scene, only: [:index]
    before_action :set_scenes, only: [:index]

    def index
      q_params = {
        production_plans: {
          produce_on: params[:produce_on],
          scene_id: params[:scene_id],
          organ_id: current_organ.provider_ids
        }
      }
      q_params.merge! params.permit('name-like')

      @productions = Production.includes(:parts, :product).joins(:production_plans).where(q_params).default.page(params[:page]).per(10)
    end

    def list
      q_params = {
        production_plans: {
          produce_on: params[:produce_on],
          scene_id: params[:scene_id],
          organ_id: current_organ.provider_ids
        }
      }
      @productions = Production.includes(:parts, :product).joins(:production_plans).where(q_params).default.page(params[:page]).per(10)
    end

    def produce_on
      @produce_plan = ProducePlan.find params[:produce_plan_id]
    end

    def scene
      @produce_plan = ProducePlan.find params[:produce_plan_id]
      q_params = { produce_on: @produce_plan.produce_on }
      q_params.merge! default_params

      @produce_plans = ProducePlan.default_where(q_params).order(id: :asc)
    end

    def show
      pc = current_cart && current_cart.production_carts.where(product_id: @product.id).order(customized_at: :desc).first
      if params[:production_id]
        @production = @product.productions.find params[:production_id]
      elsif pc
        @production = pc.production
      else
        @production = @product.production
      end
    end

    private
    def set_product
      @product = Product.find params[:id]
    end

    def set_scene
      @scene = Scene.find params[:scene_id]
    end

    def set_product_taxons
      @product_taxons = ProductTaxon.with_attached_logo.enabled.default_where(default_params).order(id: :asc)
    end

    def set_card_templates
      @card_templates = Trade::CardTemplate.default_where(default_params)
    end

    def set_product_taxon
      @product_taxon = ProductTaxon.find params[:product_taxon_id] if params[:product_taxon_id]
    end

  end
end
