module RailsFactory::ProductTaxon
  extend ActiveSupport::Concern
  included do
    prepend RailsTaxonNode
    acts_as_list
    has_many :products, dependent: :nullify
  end



end
