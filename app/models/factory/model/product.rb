module Factory
  module Model::Product
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :description, :string
      attribute :qr_prefix, :string
      attribute :sku, :string, index: true
      attribute :published, :boolean, default: true
      attribute :profit_margin, :decimal, precision: 4, scale: 2, default: 0
      attribute :min_price, :decimal
      attribute :max_price, :decimal
      attribute :specialty, :boolean, default: false
      attribute :order_items_count, :integer, default: 0
      attribute :productions_count, :integer, default: 0
      attribute :product_parts_count, :integer, default: 0
      attribute :fits_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :unifier, optional: true
      belongs_to :product_taxon, counter_cache: true, optional: true
      belongs_to :brand, counter_cache: true, optional: true

      has_one :production, -> { where(default: true) }
      has_many :productions, dependent: :destroy_async
      has_many :product_parts, dependent: :destroy_async
      has_many :parts, through: :product_parts
      has_many :product_part_taxons, dependent: :destroy_async
      has_many :part_taxons, through: :product_part_taxons
      has_many :production_carts, dependent: :destroy_async
      has_many :carts, through: :production_carts
      has_many :fits, dependent: :destroy_async

      accepts_nested_attributes_for :product_part_taxons, reject_if: :all_blank, allow_destroy: true

      has_one_attached :logo
      has_many_attached :covers
      has_many_attached :images

      has_taxons :product_taxon

      after_save :sync_name, if: -> { saved_change_to_name? }
      after_save :sync_product_taxon, if: -> { saved_change_to_product_taxon_id? }
      after_update :set_specialty, if: -> { specialty? && saved_change_to_specialty? }
    end

    def compute_min_max
      self.min_price = productions.minimum(:price)
      self.max_price = productions.maximum(:price)
      self.save
    end

    def profit_margin_str
      (profit_margin.to_d * 100).to_fs(:percentage)
    end

    def sync_name
      productions.update_all name: name
    end

    def set_specialty
      self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(specialty: false)
    end

    def sync_product_taxon
      productions.update_all(product_taxon_id: product_taxon_id)
    end

  end
end
