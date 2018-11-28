class Product < ApplicationRecord
  belongs_to :product_taxon, optional: true
  has_many :product_parts, dependent: :destroy
  has_many :parts, through: :product_parts
  has_many :product_plans, dependent: :destroy
  has_many :product_items, dependent: :destroy
  has_many :customs, dependent: :nullify


  def init_profit_price
    if product_taxon.profit_margin
      self.profit_price = self.import_price * (100 + profit_margin) / 100
    end
  end

end unless RailsFactory.config.disabled_models.include?('Product')
