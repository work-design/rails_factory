module RailsFactoryGood
  extend ActiveSupport::Concern

  included do
    attribute :import_price, :decimal, default: 0
    attribute :profit_price, :decimal, default: 0

    attribute :quantity, :decimal
    attribute :unit, :string

    before_save :sync_price, if: -> { import_price_changed? || profit_price_changed? }
  end

  private
  def sync_price
    self.price = self.import_price.to_d + self.profit_price.to_d
  end

end
