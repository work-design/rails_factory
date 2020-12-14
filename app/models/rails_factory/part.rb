module RailsFactory::Part
  extend ActiveSupport::Concern

  included do
    attribute :type, :string
    attribute :name, :string
    attribute :description, :string
    attribute :qr_prefix, :string
    attribute :sku, :string, index: true
    attribute :order_items_count, :integer, default: 0
    attribute :published, :boolean, default: true
    attribute :price, :decimal, default: 0
    attribute :import_price, :decimal, default: 0
    attribute :profit_price, :decimal, default: 0

    belongs_to :organ, optional: true
    belongs_to :part_taxon

    has_many :product_parts, dependent: :destroy
    has_many :products, through: :product_parts
    has_many :part_plans, dependent: :destroy
    has_many :part_items, dependent: :destroy
    has_many :part_providers, dependent: :destroy

    before_save :sync_part_taxon_id, if: -> { part_taxon_ancestors_changed? }
    before_save :sync_price
    after_update :sync_part_taxon_id_to_pp, if: -> { saved_change_to_part_taxon_id? }

    has_taxons :part_taxon
  end

  def taxon_str(join = ' > ')
    self.part_taxon.self_and_ancestors.pluck(:name).reverse.join(join) if self.part_taxon
  end

  private
  def sync_part_taxon_id
    self.part_taxon_id = self.part_taxon_ancestors&.values.compact.last
  end

  def sync_part_taxon_id_to_pp
    self.product_parts.update_all(part_taxon_id: self.part_taxon_id)
  end

  def sync_price
    self.price = self.import_price.to_d + self.profit_price.to_d
  end

end
