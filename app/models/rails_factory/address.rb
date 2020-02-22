module RailsFactory::Address
  extend ActiveSupport::Concern
  included do
    has_many :trade_items, dependent: :nullify
    has_many :customs, through: :trade_items, source: :good, source_type: 'Custom'
  end

end
