module Factory
  class ProducePlanJob < ApplicationJob

    def perform
      SceneAutomatic.all.each do |scene_automatic|
        (Date.today .. Date.today + scene_automatic.advance_days).each do |produce_on|
          produce_plan = ProducePlan.find_or_create_by(scene_id: scene_automatic.scene_id, organ_id: scene_automatic.organ_id, produce_on: produce_on)
          produce_plan.automatic
        end
      end
    end

  end
end
