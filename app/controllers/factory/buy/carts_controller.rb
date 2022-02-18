module Factory
  class Buy::CartsController < Buy::BaseController
    before_action :set_cart, only: [:add]

    def index
      @organs = current_organ.providers
    end

    def list
      @members = current_organ.members.order(id: :asc).page(params[:page])

      @carts = current_organ.member_carts.includes(:member, :trade_items).where(organ_id: params[:organ_id]).order(member_id: :asc).page(params[:page])
      if params[:produce_plan_id]
        @produce_plan = ProducePlan.find params[:produce_plan_id]
        @production = @produce_plan.specialty_production
        render 'list_plan'
      else
        render 'list'
      end
    end

    private
    def init_cart(member_id, organ_id)
      current_organ.member_carts.create(member_id: member_id, organ_id: organ_id)
    end

    def set_cart
      @cart = Trade::Cart.find params[:id]
    end

  end
end
