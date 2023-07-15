module Factory
  module Model::Production
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :name, :string
      attribute :qr_code, :string
      attribute :price, :decimal, default: 0
      attribute :cost_price, :decimal, default: 0, comment: '成本价'
      attribute :profit_price, :decimal, default: 0, comment: '利润'
      attribute :str_part_ids, :string, index: true
      attribute :default, :boolean, default: false
      attribute :enabled, :boolean, default: false
      attribute :automatic, :boolean, default: false
      attribute :presell, :boolean, default: false
      attribute :link, :string
      attribute :position, :integer

      enum state: {
        init: 'init',
        checked: 'checked',
        producing: 'producing'
      }, _default: 'init'

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :product, counter_cache: true
      belongs_to :product_host, optional: true
      belongs_to :product_taxon, optional: true
      belongs_to :factory_taxon, optional: true

      has_many :production_carts, dependent: :destroy_async
      has_many :carts, through: :production_carts
      has_many :downstreams, class_name: 'ProxyProduction', foreign_key: :upstream_id
      has_many :production_items, dependent: :destroy_async
      has_many :production_plans, dependent: :destroy_async

      has_many :production_parts, dependent: :destroy_async
      has_many :parts, -> { order(id: :asc) }, through: :production_parts
      has_many :part_taxons, -> { order(id: :asc) }, through: :production_parts

      has_many :same_production_parts, class_name: 'ProductionPart', primary_key: :product_id, foreign_key: :product_id
      has_many :same_productions, -> { distinct }, through: :same_production_parts, source: :production
      has_many :same_parts, -> { distinct }, through: :same_production_parts, source: :part
      has_many :same_part_taxons, -> { distinct }, through: :same_production_parts, source: :part_taxon

      has_many :brothers, class_name: self.name, primary_key: :product_id, foreign_key: :product_id

      #has_one_attached :logo
      delegate :logo, to: :product

      scope :enabled, -> { where(enabled: true) }
      scope :default, -> { where(default: true) }
      scope :list, -> { where(enabled: true, default: true) }
      scope :automatic, -> { where(automatic: true) }

      validates :str_part_ids, uniqueness: { scope: :product_id }, allow_blank: true

      after_initialize :init_name, if: :new_record?
      before_validation :sync_from_product, if: -> { product_id_changed? }
      before_save :sync_price, if: -> { (changes.keys & ['cost_price', 'profit_price']).present? }
      after_update :set_default, if: -> { default? && saved_change_to_default? }
      #after_save :compute_min_max_price, if: -> { saved_change_to_price? }
    end

    def init_name
      self.name ||= product&.name
    end

    def init_logo
      self.logo.attach product.logo_blob
    end

    def title
      parts.pluck(:name).join(',')
    end

    def order_part_ids
      p_ids = self.production_parts.pluck(:part_id)
      p_ids.sort!
      self.str_part_ids = p_ids.join(',')
    end

    def compute_min_max_price
      product_host.compute_min_max
    end

    def compute_cost_price
      self.cost_price = parts.sum(&:price)  # price 可由系统提前设定，未设定则通过零件自动计算
    end

    def disabled?(part)
      same_production_parts.where.not(production_id: self.id).where(part_id: part_ids - [part.id]).blank?
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

    def card_price_human
      codes = organ.card_templates.load.pluck(:code, :name).to_h
      card_price.each_with_object({}) { |(k, v), a| a[k] = { name: codes[k], price: v.to_d } }
    end

    def card_price_min(cart)
      human = card_price_human
      codes = cart && cart.cards.map(&->(i){ i.card_template.code })
      r = human.slice(*codes)
      if r.present?
        min = r.min_by { |_, v| v[:price] }
        min[1].merge! checked: true
      else
        min = human.min_by { |_, v| v[:price] }
      end

      min[1] if min.present?
    end

    def card_price_all(cart)
      codes = organ.card_templates.pluck(:code, :name).to_h
      check_codes = cart && cart.cards.map(&->(i){ i.card_template.code })
      card_price.each_with_object({}) { |(k, v), a| a[k] = { name: codes[k], price: v.to_d, checked: Array(check_codes).include?(k) } }
    end

    def sync_price
      self.profit_price ||= default_profit_price
      self.price = self.cost_price + self.profit_price
    end

    def sync_from_product
      self.product_taxon_id = product.product_taxon_id
      self.organ_id = product.organ_id
    end

  end
end
