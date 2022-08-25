module Factory
  class In::CartsController < In::BaseController
    before_action :set_cart, only: [:add]
    before_action :set_items
    before_action :set_scene, only: [:list]
    before_action :set_scenes, only: [:list]
    before_action :set_production, only: [:list]

    def index
      @produce_on = ProducePlan.where(organ_id: current_organ.provider_ids).effective.order(produce_on: :asc).first&.produce_on || Date.today

      ids = ProducePlan.where(produce_on: @produce_on, organ_id: current_organ.provider_ids).select(:scene_id).distinct.pluck(:scene_id)
      @scenes = Scene.where(id: ids)
    end

    def list
      @members = current_organ.members.order(id: :asc).page(params[:page])
    end

    private
    def init_cart(member_id, organ_id)
      current_organ.member_carts.create(member_id: member_id, organ_id: organ_id)
    end

    def set_items
      @items = current_member.agent_items.carting.includes(:member).where(member_organ_id: current_organ.id, produce_on: params[:produce_on], scene_id: params[:scene_id])
    end

    def set_scene
      @scene = Scene.find params[:scene_id]
    end

    def set_production
      q_params = {
        production_plans: {
          produce_on: params[:produce_on],
          scene_id: params[:scene_id],
          organ_id: current_organ.provider_ids,
          specialty: true
        }
      }

      if params[:production_id]
        @production = Production.find params[:production_id]
      else
        @production = Production.includes(:parts, :product).joins(:production_plans).where(q_params).take
      end
    end

    def set_cart
      @cart = Trade::Cart.find params[:id]
    end

  end
end
