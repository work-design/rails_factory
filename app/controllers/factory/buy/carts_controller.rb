module Factory
  class Buy::CartsController < Buy::BaseController

    def index
      @organ_ids = current_organ.member_carts.order(organ_id: :asc).select(:organ_id).distinct.page(params[:page])

      @organs = Org::Organ.find @organ_ids.pluck(:organ_id)
    end

    def list
      @carts = current_organ.member_carts.where(organ_id: params[:organ_id])
      @members = current_organ.members.page(params[:page])
    end

  end
end
