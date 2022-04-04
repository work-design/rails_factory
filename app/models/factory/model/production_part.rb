module Factory
  module Model::ProductionPart
    extend ActiveSupport::Concern

    included do
      attribute :price, :decimal, default: 0

      belongs_to :production
      belongs_to :part

      after_commit :sync_to_production, on: [:create, :destroy]
    end

    def sync_amount
    end

    def sync_to_production
      production.compute_cost_price
      production.order_part_ids
      production.save
    end

  end
end
