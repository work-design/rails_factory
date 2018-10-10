class Part < ApplicationRecord
  belongs_to :provider
  has_many :product_parts, dependent: :destroy
  has_many :products, through: :product_parts
  has_many :part_plans, dependent: :destroy
  has_many :part_items, dependent: :destroy


end
