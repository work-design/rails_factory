module RailsFactory::Product
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :description, :string
    attribute :qr_prefix, :string
    attribute :sku, :string, index: true
    attribute :type, :string
    attribute :order_items_count, :integer, default: 0
    attribute :published, :boolean, default: true
    attribute :reference_price, :decimal, precision: 10, scale: 2
    attribute :price, :decimal, precision: 10, scale: 2
    attribute :cost_price, :decimal, precision: 10, scale: 2
    attribute :profit_price, :decimal, precision: 10, scale: 2

    belongs_to :organ, optional: true
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

    has_taxons :product_taxon
  end

  def default_profit_price
    if product_taxon&.profit_margin
      self.cost_price * (100 + product_taxon.profit_margin) / 100
    else
      0
    end
  end

  def sync_price
    self.cost_price = self.parts.sum(&:price)
    self.profit_price ||= default_profit_price
    self.price = self.cost_price + self.profit_price
  end

end
