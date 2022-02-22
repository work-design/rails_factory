module Factory
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      has_many :part_providers
      has_many :parts, through: :part_providers
      has_many :good_providers, foreign_key: :provider_id, dependent: :delete_all
    end

    def name_detail
      "#{name} (#{id})"
    end

    def nearest_produce_plans
      Factory::ProducePlan.includes(:scene).default_where(organ_id: self.id).effective.order(produce_on: :asc)
    end

  end
end
