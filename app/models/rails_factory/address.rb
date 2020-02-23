module RailsFactory::Address
  extend ActiveSupport::Concern
  included do
    has_many :trade_items, dependent: :nullify
    has_many :customs, through: :trade_items, source: :good, source_type: 'Custom'
    has_many :orders, through: :trade_items, source: :trade, source_type: 'Order'
  end

end
