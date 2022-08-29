module Factory
  module Model::ProductOrgan
    extend ActiveSupport::Concern

    included do
      attribute :profit_margin, :decimal, precision: 4, scale: 2, default: 0
      attribute :min_price, :decimal
      attribute :max_price, :decimal

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :product
    end

  end
end
