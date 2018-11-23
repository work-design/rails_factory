class ProductPart < ApplicationRecord
  belongs_to :product
  belongs_to :part
  validates :part_id, uniqueness: { scope: :product_id }

end unless RailsFactory.config.disabled_models.include?('ProductPart')
