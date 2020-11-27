module RailsFactory::Address
  extend ActiveSupport::Concern

  included do
    has_many :trade_items, dependent: :nullify
    has_many :productions, through: :trade_items, source: :good, source_type: 'Production'
  end

end
