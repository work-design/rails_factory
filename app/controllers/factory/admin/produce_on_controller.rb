module Factory
  class Admin::ProduceOnController < Admin::BaseController

    def index
      @produce_ons = (Date.today - 1)..(Date.today + 5)

      q_params = {
        'produce_on-gte': @produce_ons.first,
        'produce_on-lte': @produce_ons.last
      }
      q_params.merge! default_params

      @produce_plans = ProducePlan.default_where(q_params).group_by(&->(i){ i.produce_on.to_s }).with_defaults! @produce_ons.to_a.map!(&:to_s).product([[]]).to_h
    end

  end
end
