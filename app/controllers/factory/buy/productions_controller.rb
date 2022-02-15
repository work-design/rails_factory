module Factory
  class Buy::ProductionsController < ProductionsController
    before_action :set_product_taxon
    before_action :set_produce_plans, only: [:index, :plan]
    before_action :set_product_taxons, only: [:index]
    before_action :set_product, only: [:show]
    before_action :set_card_templates, only: [:index]

    def index
      q_params = {}
      q_params.merge! params.permit(:product_taxon_id, 'name-like')

      if params[:produce_plan_id]
        if @produce_plan.expired?
          render 'expired'
        else
          @productions = @produce_plan.productions.includes(:parts, :product).default.default_where(q_params).page(params[:page]).per(10)
        end
      else
        @productions = Production.includes(:parts, :product).enabled.default.default_where(q_params).page(params[:page]).per(10)
      end
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

    def set_product_taxons
      @product_taxons = ProductTaxon.with_attached_logo.enabled.default_where(default_params).order(id: :asc)
    end

    def set_card_templates
      @card_templates = Trade::CardTemplate.default_where(default_params)
    end

    def set_produce_plans
      if params[:produce_plan_id]
        @produce_plan = ProducePlan.find params[:produce_plan_id]

        q_params = { produce_on: @produce_plan.produce_on }
        q_params.merge! default_params
        q_params.merge! params.permit(:produce_on)

        @produce_plans = ProducePlan.default_where(q_params).order(id: :asc)
      else
        @produce_plans = ProducePlan.none
      end
    end

    def set_product_taxon
      @product_taxon = ProductTaxon.find params[:product_taxon_id] if params[:product_taxon_id]
    end

  end
end
