module RailsFactory::Production
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :qr_code, :string
    attribute :price, :decimal
    attribute :cost_price, :decimal, default: 0
    attribute :profit_price, :decimal
    attribute :str_part_ids, :string
    attribute :default, :boolean, default: false

    enum state: {
      init: 'init',
      checked: 'checked',
      producing: 'producing'
    }, _default: 'init'

    belongs_to :product
    has_many :production_parts, dependent: :destroy
    has_many :parts, through: :production_parts
    has_many :production_carts, dependent: :destroy
    has_many :carts, through: :production_carts
    has_many :part_providers, dependent: :destroy
    has_many :provided_parts, through: :part_providers, source: :part

    has_one_attached :logo

    after_initialize if: :new_record? do
      if product_id && part_ids.blank?
        self.part_ids = product.part_ids
      end
      compute_sum
      if product
        self.organ_id = product.organ_id if defined? :organ_id
        self.name ||= product.name
        self.logo.attach product.logo_blob
      end
    end
    before_validation :sync_price, if: -> { (changes.keys & ['cost_price', 'profit_price']).present? }
    after_update :set_default, if: -> { default? && saved_change_to_default? }
  end

  def title
    parts.pluck(:name).join(',')
  end

  def compute_sum
    self.production_parts.each(&:sync_amount)
    self.price = production_parts.sum(&:price)
  end

  def set_default
    self.class.where.not(id: self.id).where(product_id: self.product_id).update_all(default: false)
  end

  def default_profit_price
    if product.profit_margin
      self.cost_price * (100 + product.profit_margin) / 100
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
