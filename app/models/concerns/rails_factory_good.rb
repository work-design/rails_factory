module RailsFactoryGood
  extend ActiveSupport::Concern

  included do

    attribute :import_price, :decimal, default: 0
    attribute :profit_price, :decimal, default: 0

    attribute :quantity, :decimal
    attribute :unit, :string
  end

end
