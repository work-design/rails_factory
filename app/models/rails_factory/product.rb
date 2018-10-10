class Product < ApplicationRecord
  has_many :product_parts, dependent: :destroy
  has_many :parts, through: :product_parts
  has_many :product_plans, dependent: :destroy
  has_many :product_items, dependent: :destroy


end
