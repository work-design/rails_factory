module Factory
  module Model::Product
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :name, :string
      attribute :description, :string
      attribute :qr_prefix, :string
      attribute :sku, :string, index: true
      attribute :published, :boolean, default: true
      attribute :specialty, :boolean, default: false
      attribute :order_items_count, :integer, default: 0
      attribute :productions_count, :integer, default: 0
      attribute :product_parts_count, :integer, default: 0
      attribute :fits_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :unifier, optional: true
      belongs_to :product_taxon, counter_cache: true, optional: true
      belongs_to :factory_taxon, optional: true
      belongs_to :brand, counter_cache: true, optional: true
      belongs_to :upstream, class_name: 'Product', optional: true  # 对应供应链产品

      has_one :production, -> { where(default: true) }
      has_many :downstreams, class_name: self.name, foreign_key: :upstream_id
      has_many :productions, dependent: :destroy_async
      has_many :proxy_productions, dependent: :destroy_async
      has_many :product_parts, dependent: :destroy_async
      has_many :parts, through: :product_parts
      has_many :part_products, class_name: 'ProductPart', foreign_key: :part_id, dependent: :destroy_async
      has_many :product_part_taxons, dependent: :destroy_async
      accepts_nested_attributes_for :product_part_taxons, reject_if: :all_blank, allow_destroy: true
      has_many :part_taxons, through: :product_part_taxons
      has_many :production_carts, dependent: :destroy_async
      has_many :carts, through: :production_carts
      has_many :fits, dependent: :destroy_async
      has_many :product_hosts
      accepts_nested_attributes_for :product_hosts

      has_one_attached :logo
      has_many_attached :covers
      has_many_attached :images

      has_taxons :product_taxon

      before_validation :sync_from_upstream, if: -> { upstream_id_changed? }
      before_save :sync_from_product_taxon, if: -> { product_taxon_id_changed? }
      after_save :sync_product_taxon, if: -> { saved_change_to_product_taxon_id? }
      after_update :set_specialty, if: -> { specialty? && saved_change_to_specialty? }
    end

    def sync_from_upstream
      self.name = upstream&.name
      self.logo.attach upstream&.logo_blob
    end

    def sync_from_product_taxon
      self.factory_taxon_id = product_taxon.factory_taxon_id
    end

    def sync_name
      productions.update_all name: name
    end

    def set_specialty
      self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(specialty: false)
    end

    def sync_product_taxon
      productions.update_all(product_taxon_id: product_taxon_id)
      productions.update_all(factory_taxon_id: factory_taxon_id)
    end

  end
end
