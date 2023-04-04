module Factory
  class Our::ProductionsController < ProductionsController
    include Controller::Our
    before_action :set_factory_taxon, if: -> { params[:factory_taxon_id].present? }
    before_action :set_produce_plans, only: [:index, :plan]
    before_action :set_production, only: [:show]
    before_action :set_card_templates, only: [:index]
    before_action :set_scene, only: [:index], if: -> { params[:scene_id].present? }
    # before_action :set_scenes, only: [:index], if: -> { params[:scene_id].present? }
    before_action :set_cart, only: [:index]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! production_plans: { produce_on: params[:produce_on], scene_id: params[:scene_id] } if params[:produce_on] && params[:scene_id]
      q_params.merge! params.permit('name-like', :factory_taxon_id)

      @productions = Production.includes(:parts, :production_plans, product: { logo_attachment: :blob }).default_where(q_params).default.order(id: :desc).page(params[:page]).per(params[:per])
    end

    def list
      q_params = {
        production_plans: {
          produce_on: params[:produce_on],
          scene_id: params[:scene_id]
        },
      }
      q_params.merge! default_params

      @productions = Production.includes(:parts, :production_plans, product: { logo_attachment: :blob }).default_where(q_params).default.page(params[:page]).per(10)
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

    private
    def set_production
      @production = Production.find params[:id]
    end

    def set_scene
      @scene = Scene.find params[:scene_id]
    end

    def set_card_templates
      @card_templates = Trade::CardTemplate.default_where(default_params)
    end

    def set_factory_taxon
      @factory_taxon = FactoryTaxon.find params[:factory_taxon_id]
    end

    def set_cart
      @cart = current_carts.find_or_create_by(good_type: 'Factory::Production', aim: 'use')
    end

    def _prefixes
      super do |pres|
        pres + ['factory/in/productions', "factory/in/productions/_#{params[:action]}", 'factory/in/productions/_base']
      end
    end

  end
end
