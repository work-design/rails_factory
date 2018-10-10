class ProductPlan < ApplicationRecord
  belongs_to :product
  has_many :product_items


  enum state: {
    planned: 'planned',
    producing: 'producing',
    produced: 'produced'
  }

end
