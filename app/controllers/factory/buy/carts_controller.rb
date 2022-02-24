module Factory
  class Buy::CartsController < Buy::BaseController
    include Controller::Buy
    before_action :set_cart, only: [:add]
    before_action :set_trade_items
    before_action :set_scene, only: [:list]
    before_action :set_scenes, only: [:list]

    def index
      @organs = current_organ.providers
    end

    def list
      @members = current_organ.members.order(id: :asc).page(params[:page])

      @carts = current_organ.member_carts.includes(:member, :trade_items).where(organ_id: params[:organ_id]).order(member_id: :asc).page(params[:page])
      if params[:production_id]
        @production = Production.find params[:production_id]
      else
        @production = Production.first || @produce_plan.specialty_production
      end
    end

    private
    def init_cart(member_id, organ_id)
      current_organ.member_carts.create(member_id: member_id, organ_id: organ_id)
    end

    def set_trade_items
      @trade_items = current_member.agent_trade_items.carting.includes(:member).where(member_organ_id: current_organ.id, produce_on: params[:produce_on], scene_id: params[:scene_id])
    end

    def set_scene
      @scene = Scene.find params[:scene_id]
    end

    def set_cart
      @cart = Trade::Cart.find params[:id]
    end

  end
end
