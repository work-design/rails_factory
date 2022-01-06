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

    private
    def xx
      q_params = {
        'book_finish_at-gt': Time.current
      }
      q_params.merge! default_params

      @produce_plans = Factory::ProducePlan.default_where(q_params).includes(:scene).order(produce_on: :asc).group_by(&:produce_on)
      @produce_on = @produce_plans.keys[0]
      if @produce_on
        @produce_plans = @produce_plans[@produce_on]
        @produce_plan = @produce_plans.find(&->(i){ i.scene == Factory::Scene.default_where(default_params).specialty.take })
      else
        @produce_plans = Factory::ProducePlan.none
        @produce_on = Date.today
      end
    end

  end
end
