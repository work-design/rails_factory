module Factory
  module Model::Address
    extend ActiveSupport::Concern

    included do
      has_many :trade_items, class_name: 'Trade::TradeItem', dependent: :nullify
      has_many :productions, class_name: 'Factory::Production', through: :trade_items, source: :good, source_type: 'Factory::Production'
    end

  end
end
