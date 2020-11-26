module RailsFactory::Product
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :description, :string
    attribute :qr_prefix, :string
    attribute :sku, :string, index: true
    attribute :order_items_count, :integer, default: 0
    attribute :published, :boolean, default: true
    attribute :str_part_ids, :string

    belongs_to :organ, optional: true
    belongs_to :product_taxon, optional: true

    has_many :productions, dependent: :destroy
    has_many :product_parts, dependent: :destroy
    has_many :parts, through: :product_parts
    has_many :part_taxons, -> { distinct }, through: :product_parts
    has_many :product_plans, dependent: :destroy
    has_many :product_items, dependent: :destroy
    has_many :product_carts, dependent: :destroy
    has_many :carts, through: :product_carts

    has_one_attached :logo
    has_many_attached :covers
    has_many_attached :images

    before_save :sync_price, if: -> { (changes.keys & ['cost_price', 'profit_price']).present? }

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
    if self.parts.present?
      self.cost_price = self.parts.sum(&:price)
    end

    self.profit_price ||= default_profit_price
    self.price = self.cost_price + self.profit_price
  end

end
