module Factory
  class ProducePlanPruneJob < ApplicationJob

    def perform
      ProducePlan.default_where('produce_on-lt': Date.today, production_plans_count: 0).delete_all
    end

  end
end
