class Custom < ApplicationRecord
  belongs_to :customer, polymorphic: true
  has_many :custom_parts, dependent: :destroy
  has_many :parts, through: :custom_parts


end unless RailsFactory.config.disabled_models.include?('Custom')
