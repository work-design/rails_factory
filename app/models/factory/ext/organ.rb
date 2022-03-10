module Factory
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_many :part_providers, class_name: 'Factory::PartProvider', foreign_key: :provider_id, dependent: :destroy_async
      has_many :parts, class_name: 'Factory::Part', through: :part_providers
      has_many :factory_providers, class_name: 'Factory::FactoryProvider', foreign_key: :provider_id, dependent: :destroy_async
    end

    def name_detail
      "#{name} (#{id})"
    end

    def nearest_produce_plans
      Factory::ProducePlan.includes(:scene).default_where(organ_id: self.id).effective.order(produce_on: :asc)
    end

  end
end
