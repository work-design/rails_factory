module Factory
  module Model::ProductionPart
    extend ActiveSupport::Concern

    included do
      attribute :price, :decimal, default: 0

      belongs_to :production
      belongs_to :part
    end

    def sync_amount
      self.price = part.price
    end

  end
end
