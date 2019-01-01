class Custom < ApplicationRecord
  belongs_to :product
  belongs_to :customer, polymorphic: true
  has_many :custom_parts, dependent: :destroy
  has_many :parts, through: :custom_parts

  after_initialize if: :new_record? do
    if product_id && part_ids.blank?
      self.part_ids = product.part_ids
    end
  end

end unless RailsFactory.config.disabled_models.include?('Custom')
