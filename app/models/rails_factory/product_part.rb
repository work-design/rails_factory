module RailsFactory::ProductPart
  extend ActiveSupport::Concern

  included do
    attribute :original_price, :decimal, default: 0
    attribute :price, :decimal, default: 0

    belongs_to :product
    belongs_to :part
    belongs_to :part_taxon

    validates :part_id, uniqueness: { scope: :product_id }

    before_validation :sync_part_taxon, on: :create
  end

  def sync_amount
    self.original_price = part.price
    self.price = self.original_price
  end

  def sync_part_taxon
    self.part_taxon_id = self.part.part_taxon_id
  end

end
