module RailsFactory::ProductPlan
  extend ActiveSupport::Concern

  included do
    attribute :start_at, :datetime
    attribute :finish_at, :datetime
    attribute :state, :string
    attribute :planned_count, :integer, default: 0
    attribute :produced_count, :integer, default: 0

    belongs_to :product
    has_many :product_items

    enum state: {
      planned: 'planned',
      producing: 'producing',
      produced: 'produced'
    }
  end

end
