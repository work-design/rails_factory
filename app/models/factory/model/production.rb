module Factory
  module Model::Production
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :qr_code, :string
      attribute :price, :decimal, default: 0
      attribute :cost_price, :decimal, default: 0
      attribute :profit_price, :decimal, default: 0
      attribute :str_part_ids, :string
      attribute :default, :boolean, default: false

      enum state: {
        init: 'init',
        checked: 'checked',
        producing: 'producing'
      }, _default: 'init'

      belongs_to :product, counter_cache: true

      has_many :production_parts, dependent: :destroy
      has_many :parts, through: :production_parts
      has_many :production_carts, dependent: :destroy
      has_many :carts, through: :production_carts
      has_many :part_providers, dependent: :destroy
      has_many :provided_parts, through: :part_providers, source: :part
      has_many :production_items, dependent: :destroy

      #has_one_attached :logo
      delegate :logo, to: :product

      after_initialize if: :new_record? do
        if product_id && part_ids.blank?
          self.part_ids = product.part_ids
        end
        compute_sum
        if product
          self.name = product.name
          self.logo.attach product.logo_blob
        end
      end
      before_validation :sync_price, if: -> { (changes.keys & ['cost_price', 'profit_price']).present? }
      after_update :set_default, if: -> { default? && saved_change_to_default? }
      after_save :compute_min_max_price, if: -> { saved_change_to_price? }
    end

    def title
      parts.pluck(:name).join(',')
    end

    def compute_min_max_price
      product.compute_min_max
    end

    def compute_sum
      self.production_parts.each(&:sync_amount)
      self.price ||= production_parts.sum(&:price)  # price 可由系统提前设定，未设定则通过零件自动计算
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
end
