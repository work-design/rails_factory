module RailsFactory::ProductPlan
  extend ActiveSupport::Concern
  included do
    belongs_to :product
    has_many :product_items
    
    enum state: {
      planned: 'planned',
      producing: 'producing',
      produced: 'produced'
    }
  end
  
end
