module Factory
  class Buy::CartsController < Buy::BaseController

    def index
      @organ_ids = current_organ.member_carts.order(organ_id: :asc).select(:organ_id).distinct.page(params[:page])

      @organs = Org::Organ.find @organ_ids.pluck(:organ_id)
    end

    def list
      @cart_member_ids = current_organ.member_carts.where(organ_id: params[:organ_id]).pluck(:member_id)
      @members = current_organ.members.page(params[:page])

      (@members.pluck(:id) - @cart_member_ids).each do |member_id|
        init_cart(member_id, current_organ.id)
      end
    end

    private
    def init_cart(member_id, organ_id)
      current_organ.member_carts.create(member_id: member_id, organ_id: organ_id)
    end

  end
end
