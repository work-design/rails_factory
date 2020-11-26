module RailsFactory::ProductionPart
  extend ActiveSupport::Concern

  included do
    attribute :original_price, :decimal, default: 0
    attribute :price, :decimal, default: 0

    belongs_to :production
    belongs_to :part
  end

  def sync_amount
    self.original_price = part.price
    self.price = self.original_price
  end

end
