class Custom < ApplicationRecord
  belongs_to :product
  belongs_to :customer, polymorphic: true
  has_many :custom_parts, dependent: :destroy
  has_many :parts, through: :custom_parts

  after_initialize if: :new_record? do
    self.part_ids = product.part_ids
  end

end unless RailsFactory.config.disabled_models.include?('Custom')
