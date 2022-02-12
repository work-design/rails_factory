module Factory
  class Buy::CartsController < Buy::BaseController
    before_action :set_cart, only: [:add]

    def index
      @organ_ids = current_organ.member_carts.order(organ_id: :asc).select(:organ_id).distinct.page(params[:page])

      @organs = Org::Organ.find @organ_ids.pluck(:organ_id)
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
