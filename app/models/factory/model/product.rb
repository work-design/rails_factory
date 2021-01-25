module Factory
  module Model::Product
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :description, :string
      attribute :qr_prefix, :string
      attribute :sku, :string, index: true
      attribute :order_items_count, :integer, default: 0
      attribute :published, :boolean, default: true
      attribute :str_part_ids, :string
      attribute :profit_margin, :decimal, precision: 4, scale: 2
      attribute :min_price, :decimal
      attribute :max_price, :decimal

      belongs_to :organ, optional: true
      belongs_to :product_taxon, optional: true, counter_cache: true

      has_one :production, -> { where(default: true) }
      has_many :productions, dependent: :destroy
      has_many :product_parts, dependent: :destroy
      has_many :parts, through: :product_parts
      has_many :product_part_taxons, dependent: :destroy
      has_many :part_taxons, through: :product_part_taxons
      has_many :product_plans, dependent: :destroy
      has_many :production_carts, dependent: :destroy
      has_many :carts, through: :production_carts

      accepts_nested_attributes_for :product_part_taxons, reject_if: :all_blank, allow_destroy: true

      has_one_attached :logo
      has_many_attached :covers
      has_many_attached :images

      has_taxons :product_taxon
      after_save :sync_name, if: -> { saved_change_to_name? }
    end

    def compute_min_max
      self.min_price = productions.minimum(:price)
      self.max_price = productions.maximum(:price)
      self.save
    end

    def profit_margin_str
      (profit_margin * 100).to_s(:percentage)
    end

    def sync_name
      productions.update_all name: name
    end

  end
end
