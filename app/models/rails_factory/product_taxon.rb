require 'acts_as_list'
class ProductTaxon < ApplicationRecord
  prepend RailsTaxonNode
  acts_as_list

  has_many :products, dependent: :nullify




end unless RailsFactory.config.disabled_models.include?('ProductTaxon')
