module Factory
  module Model::ProductionPart
    extend ActiveSupport::Concern

    included do
      attribute :price, :decimal, default: 0

      belongs_to :production
      belongs_to :part

      after_create_commit :sync_to_production
    end

    def sync_amount
      self.price = part.price
    end

    def sync_to_production
      production.order_part_ids
    end

  end
end
