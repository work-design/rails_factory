module Factory
  class Buy::CartsController < Buy::BaseController
    before_action :set_cart, only: [:add]

    def index
      @organ_ids = current_organ.member_carts.order(organ_id: :asc).select(:organ_id).distinct.page(params[:page])

      @organs = Org::Organ.find @organ_ids.pluck(:organ_id)
    end

    def list
      @cart_member_ids = current_organ.member_carts.where(organ_id: params[:organ_id]).pluck(:member_id)
      @members = current_organ.members.order(id: :asc).page(params[:page])
      (@members.pluck(:id) - @cart_member_ids).each do |member_id|
        init_cart(member_id, params[:organ_id])
      end

      @carts = current_organ.member_carts.includes(:member, :trade_items).where(organ_id: params[:organ_id]).order(member_id: :asc).page(params[:page])
      if params[:produce_plan_id]
        @produce_plan = ProducePlan.find params[:produce_plan_id]
        @production = @produce_plan.specialty_production
        render 'list_plan'
      else
        render 'list'
      end
    end

    def add
      trade_item = @cart.trade_items.find(&->(i){ i.good_id.to_s == params[:good_id] && i.good_type == params[:good_type] && i.produce_plan_id.to_s == params[:produce_plan_id].to_s }) ||
        @cart.trade_items.build(good_id: params[:good_id], good_type: params[:good_type], produce_plan_id: params[:produce_plan_id])
      if trade_item.persisted? && trade_item.checked?
        params[:number] ||= 1
        trade_item.number += params[:number].to_i
      elsif trade_item.persisted? && trade_item.init?
        trade_item.status = 'checked'
        trade_item.number = 1
      else
        trade_item.status = 'checked'
      end
      trade_item.save

      @trade_items = @cart.trade_items.page(params[:page])
      @checked_ids = @cart.trade_items.checked.pluck(:id)
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
