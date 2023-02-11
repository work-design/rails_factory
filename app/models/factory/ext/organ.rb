module Factory
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_many :factory_providers, class_name: 'Factory::FactoryProvider', foreign_key: :provider_id, dependent: :destroy_async
      has_many :provides, class_name: 'Factory::Provide', dependent: :destroy_async
      has_many :providers, through: :provides
    end

    def name_detail
      "#{name} (#{id})"
    end

    def nearest_produce_plans
      Factory::ProducePlan.includes(:scene).default_where(organ_id: self.id).effective.order(produce_on: :asc)
    end

  end
end
