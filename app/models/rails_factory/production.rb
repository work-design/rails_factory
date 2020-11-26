module RailsFactory::Production
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :qr_code, :string
    attribute :price, :decimal
    attribute :cost_price, :decimal
    attribute :profit_price, :decimal
    attribute :str_part_ids, :string

    enum state: {
      init: 'init',
      checked: 'checked',
      producing: 'producing'
    }, _default: 'init'

    belongs_to :organ, optional: true
    belongs_to :product
    belongs_to :product_plan, optional: true
    has_many :production_parts, dependent: :destroy
    has_many :parts, through: :production_parts
    has_many :production_carts, dependent: :destroy
    has_many :carts, through: :production_carts

    has_one_attached :logo

    after_initialize if: :new_record? do
      if product_plan
        self.product ||= product_plan.product
      end
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
    before_validation :compute_sum
  end

  def title
    parts.pluck(:name).join(',')
  end

  def compute_sum
    self.production_parts.each(&:sync_amount)
    self.price = production_parts.sum(&:price)
  end

end
