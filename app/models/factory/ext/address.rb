module Factory
  module Ext::Address
    extend ActiveSupport::Concern

    included do
      has_many :items, class_name: 'Trade::Item', dependent: :nullify
      has_many :productions, class_name: 'Factory::Production', through: :trade_items, source: :good, source_type: 'Factory::Production'
    end

  end
end
