module Factory
  class In::CartsController < In::BaseController
    before_action :set_cart, only: [:show, :add]
    before_action :set_organ_cart, only: [:list]
    before_action :set_items, only: [:show, :list]
    before_action :set_scene, only: [:list]
    before_action :set_scenes, only: [:list]
    before_action :set_production, only: [:list]

    def index

    end

    def list
      @members = current_organ.members.order(id: :asc).page(params[:page])
    end

    private
    def init_cart(member_id, organ_id)
      current_organ.member_carts.create(member_id: member_id, organ_id: organ_id)
    end

    def set_items
      @items = @cart.items.carting.includes(:member).where(member_organ_id: current_organ.id, produce_on: params[:produce_on], scene_id: params[:scene_id])
    end

    def set_scene
      @scene = Scene.find params[:scene_id]
    end

    def set_scenes
      @scenes = Scene.all
    end

    def set_production
      q_params = {
        production_plans: {
          produce_on: params[:produce_on],
          scene_id: params[:scene_id],
          organ_id: current_organ.provider_ids
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

    def set_organ_cart
      @cart = current_organ.member_carts.find_by(member_id: nil) || current_organ.member_carts.create(member_id: nil)
    end

  end
end
