module RailsFactory::ProductPart
  extend ActiveSupport::Concern
  included do
    belongs_to :product
    belongs_to :part
    belongs_to :part_taxon, optional: true
    validates :part_id, uniqueness: { scope: :product_id }
  
    before_save :sync_part_taxon
  end
  
  def sync_part_taxon
    self.part_taxon_id = self.part.part_taxon_id
  end

end
