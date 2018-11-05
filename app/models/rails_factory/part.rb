class Part < ApplicationRecord
  attribute :part_taxon_ancestors

  belongs_to :part_taxon, optional: true
  has_many :product_parts, dependent: :destroy
  has_many :products, through: :product_parts
  has_many :part_plans, dependent: :destroy
  has_many :part_items, dependent: :destroy

  has_many :good_providers, as: :good, dependent: :destroy

  before_save :sync_part_taxon_id, if: -> { part_taxon_ancestors_changed? }


  private
  def sync_part_taxon_id
    self.part_taxon_id = self.part_taxon_ancestors&.values.compact.last
  end

end unless RailsFactory.config.disabled_models.include?('Part')
