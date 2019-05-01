module RailsFactory::Product
  extend ActiveSupport::Concern
  included do
    belongs_to :product_taxon, optional: true
    has_many :product_parts, dependent: :destroy
    has_many :parts, through: :product_parts
    has_many :part_taxons, -> { distinct }, through: :product_parts
    has_many :product_plans, dependent: :destroy
    has_many :product_items, dependent: :destroy
    has_many :customs, dependent: :nullify
  
    has_one_attached :logo
    has_one_attached :main_image
  
    before_save :sync_price
  end
  
  def init_profit_price
    if product_taxon&.profit_margin
      self.profit_price = self.import_price * (100 + profit_margin) / 100
    else
      self.profit_price = 0
    end
  end

  def sync_price
    self.import_price = self.parts.sum(&:price)
    init_profit_price
    self.price = self.import_price + self.profit_price
  end

end
