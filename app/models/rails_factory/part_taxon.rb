require 'acts_as_list'
class PartTaxon < ApplicationRecord
  prepend TheNodeModel
  acts_as_list

  has_many :parts, dependent: :nullify

end unless RailsFactory.config.disabled_models.include?('PartTaxon')
