module Factory
  class Our::CartsController < Our::BaseController
    before_action :set_cart, only: [:show, :add]
    before_action :set_organ_cart, only: [:list]
    before_action :set_items, only: [:show, :list]
    before_action :set_scene, only: [:list]
    before_action :set_scenes, only: [:list]
    before_action :set_production, only: [:list]

    def index
      @produce_on = ProducePlan.where(organ_id: current_organ.id).effective.order(produce_on: :asc).first&.produce_on || Date.today

      ids = ProducePlan.where(produce_on: @produce_on, organ_id: current_organ.id).select(:scene_id).distinct.pluck(:scene_id)
      @scenes = Scene.where(id: ids)
    end

 

    private
    def set_items
      @items = @cart.items.includes(:member).where(member_organ_id: current_client.organ_id, produce_on: params[:produce_on], scene_id: params[:scene_id])
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
          scene_id: params[:scene_id]
        }
      }
      q_params.merge! default_params

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
      @cart = current_client.organ.member_carts.find_by(good_type: 'Factory::Production', member_id: nil) || current_client.organ.member_carts.create(good_type: 'Factory::Production', member_id: nil)
      logger.debug "\e[35m  Organ Cart: #{@cart.id} #{@cart.error_text}  \e[0m"
    end

  end
end
