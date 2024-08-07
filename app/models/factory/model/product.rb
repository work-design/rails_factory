module Factory
  module Model::Product
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :description, :string
      attribute :qr_prefix, :string
      attribute :sku, :string, index: true
      attribute :published, :boolean, default: true
      attribute :specialty, :boolean, default: false
      attribute :base_price, :decimal
      attribute :order_items_count, :integer, default: 0
      attribute :productions_count, :integer, default: 0
      attribute :product_parts_count, :integer, default: 0
      attribute :fits_count, :integer, default: 0
      attribute :position, :integer
      attribute :profit_margin, :decimal, precision: 4, scale: 2, default: 0
      attribute :min_price, :decimal
      attribute :max_price, :decimal

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :unifier, optional: true
      belongs_to :factory_taxon, optional: true
      belongs_to :taxon, counter_cache: true, optional: true
      belongs_to :brand, counter_cache: true, optional: true

      has_one :production, -> { where(default: true) }
      has_many :productions, dependent: :destroy_async
      has_many :production_provides, dependent: :destroy_async
      has_many :product_parts, dependent: :destroy_async
      has_many :parts, through: :product_parts
      has_many :part_products, class_name: 'ProductPart', foreign_key: :part_id, dependent: :destroy_async
      has_many :product_part_taxons, ->(o){ where(product_id: [o.id, nil]) }, primary_key: :taxon_id, foreign_key: :taxon_id
      has_many :part_taxons, through: :product_part_taxons
      has_many :production_carts, dependent: :destroy_async
      has_many :carts, through: :production_carts
      has_many :fits, dependent: :destroy_async
      has_many :product_hosts

      accepts_nested_attributes_for :product_part_taxons, reject_if: :all_blank, allow_destroy: true
      accepts_nested_attributes_for :productions
      accepts_nested_attributes_for :product_hosts

      has_one_attached :logo
      has_many_attached :covers
      has_many_attached :images

      scope :published, -> { where(published: true) }

      has_taxons :taxon
      positioned on: :organ_id

      before_save :sync_from_taxon, if: -> { taxon_id_changed? }
      after_save :sync_taxon, if: -> { saved_change_to_taxon_id? }
      after_update :set_specialty, if: -> { specialty? && saved_change_to_specialty? }
      after_save_commit :sync_position_later, if: -> { saved_change_to_position? }
    end

    def profit_margin_str
      (profit_margin.to_d * 100).to_fs(:percentage)
    end

    def compute_min_max!
      self.min_price = productions.minimum(:price)
      self.max_price = productions.maximum(:price)
      self.save
    end

    def sync_from_taxon
      self.factory_taxon_id = taxon.factory_taxon_id
      self.organ_id = taxon.organ_id
    end

    def sync_name
      productions.update_all name: name
    end

    def sync_position_later
      ProductSyncPositionJob.perform_later(self)
    end

    def sync_position
      self.class.where(taxon_id: taxon_id).find_each do |p|
        p.productions.update_all position: p.position
      end
    end

    def set_specialty
      self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(specialty: false)
    end

    def sync_taxon
      productions.update_all(
        taxon_id: taxon_id,
        factory_taxon_id: factory_taxon_id,
        organ_id: organ_id
      )
    end

  end
end
