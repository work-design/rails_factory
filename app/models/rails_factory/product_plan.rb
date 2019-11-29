module RailsFactory::ProductPlan
  extend ActiveSupport::Concern
  included do
    t.datetime :start_at
    t.datetime :finish_at
    t.string :state
    t.integer :planned_count, default: 0
    t.integer :produced_count, default: 0
    belongs_to :product
    has_many :product_items
    
    enum state: {
      planned: 'planned',
      producing: 'producing',
      produced: 'produced'
    }
  end
  
end
