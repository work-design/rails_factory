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
    attribute :profit_margin, :decimal, precision: 4, scale: 2

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

    has_taxons :product_taxon
  end

end
