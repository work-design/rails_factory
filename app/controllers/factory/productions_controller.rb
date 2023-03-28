module Factory
  class ProductionsController < BaseController
    before_action :set_product_taxon
    before_action :set_station, only: [:index, :show]
    before_action :set_produce_plans, only: [:index, :plan]
    before_action :set_product_taxons, only: [:index]
    before_action :set_card_templates, only: [:index]
    before_action :set_production, only: [:show, :dialog]
    before_action :set_scene, only: [:index], if: -> { params[:produce_on].present? && params[:scene_id].present? }
    before_action :set_cart, only: [:index, :show, :dialog]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:product_taxon_id, 'name-like')

      if @produce_plan
        if @produce_plan.expired?
          render 'expired'
        else
          @productions = @produce_plan.productions.includes(:parts, :product).default.default_where(q_params).order(id: :asc).page(params[:page]).per(10)
        end
      else
        @productions = Production.includes(:parts, :product).enabled.default.default_where(q_params).order(id: :asc).page(params[:page]).per(10)
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
    end

    def dialog
    end

    def create_dialog
      r = production_params.fetch(:part_ids, []).reject(&:blank?).map!(&:to_i).sort!
      @production = Production.find_or_initialize_by(product_id: production_params[:product_id], str_part_ids: r.join(','))
      @production.assign_attributes production_params
      @production.save!
    end

    def create
      r = production_params.fetch(:part_ids, []).reject(&:blank?).map!(&:to_i).sort!
      @production = Production.find_or_initialize_by(product_id: production_params[:product_id], str_part_ids: r.join(','))
      @production.assign_attributes production_params
      @production.save!
    end

    private
    def set_production
      @production = Production.find params[:id]
    end

    def set_scene
      @scene = Scene.find_by id: params[:scene_id]
      @next_plan = ProducePlan.next_plan(organ_ids: current_organ.id, produce_on: params[:produce_on].to_date, scene_id: params[:scene_id])
      @prev_plan = ProducePlan.prev_plan(organ_ids: current_organ.id, produce_on: params[:produce_on].to_date, scene_id: params[:scene_id])

      ids = Factory::ProducePlan.where(produce_on: params[:produce_on], organ_id: current_organ.id).select(:scene_id).distinct.pluck(:scene_id)
      @scenes = Factory::Scene.where(id: ids)
    end

    def set_product_taxons
      q_params = {
        'products_count-gt': 0
      }
      q_params.merge! default_params
      @product_taxons = ProductTaxon.with_attached_logo.enabled.default_where(q_params).order(id: :asc)
    end

    def set_card_templates
      @card_templates = Trade::CardTemplate.default_where(default_params)
    end

    def set_produce_plans
      if params[:produce_on] && params[:scene_id]
        @produce_plan = ProducePlan.find_by(produce_on: params[:produce_on], scene_id: params[:scene_id])
      end
      if @produce_plan
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

    def set_cart
      options = {}
      options.merge! default_form_params
      options.merge! client_params

      if current_user
        @cart = Trade::Cart.where(options).find_or_create_by(good_type: 'Factory::Production', aim: 'use')
      end
    end

    def set_station
      if params[:desk_id]
        @station = Space::Desk.find params[:desk_id]
      elsif params[:station_id]
        @station = Space::Station.find params[:station_id]
      end
    end

    def production_params
      params.fetch(:production, {}).permit(
        :product_id,
        part_ids: []
      )
    end

  end
end
