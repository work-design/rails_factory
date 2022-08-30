module Factory
  module Controller::In
    extend ActiveSupport::Concern

    included do
      layout 'in'
    end

    def set_scenes
      @next_plan = ProducePlan.next_plan(organ_ids: current_organ.provider_ids, produce_on: params[:produce_on].to_date, scene_id: params[:scene_id])
      @prev_plan = ProducePlan.prev_plan(organ_ids: current_organ.provider_ids, produce_on: params[:produce_on].to_date, scene_id: params[:scene_id])

      ids = Factory::ProducePlan.where(produce_on: params[:produce_on], organ_id: current_organ.provider_ids).select(:scene_id).distinct.pluck(:scene_id)
      @scenes = Factory::Scene.where(id: ids)
    end

    class_methods do
      def local_prefixes
        [controller_path, 'factory/in/base', 'admin']
      end
    end

  end
end
