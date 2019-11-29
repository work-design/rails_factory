module RailsFactory::CustomPart
  extend ActiveSupport::Concern

  included do
    attribute :original_price, :decimal, precision: 10, scale: 2, default: 0
    attribute :price, :decimal, precision: 10, scale: 2, default: 0

    belongs_to :custom
    belongs_to :part
  end
  
  def sync_amount
    self.original_price = part.price
    self.price = self.original_price
  end

end
