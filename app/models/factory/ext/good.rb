module Factory
  module Ext::Good
    extend ActiveSupport::Concern

    included do
      attribute :import_price, :decimal, default: 0
      attribute :profit_price, :decimal, default: 0

      attribute :quantity, :decimal
      attribute :unit, :string

      before_save :sync_price, if: -> { (changes.keys & ['import_price', 'profit_price']).present? }
    end

    private
    def sync_price
      self.price = self.import_price.to_d + self.profit_price.to_d
    end

  end
end
