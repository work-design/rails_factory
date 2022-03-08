module Factory
  class ProducePlanJob < ApplicationJob

    def perform
      SceneAutomatic.all.each do |scene_automatic|
        produce_plan = ProducePlan.new(scene_id: scene_automatic.scene_id, organ_id: scene_automatic.organ_id)
        produce_plan.save
      end
    end

  end
end
