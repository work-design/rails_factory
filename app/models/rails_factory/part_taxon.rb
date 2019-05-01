module RailsFactory::PartTaxon
  extend ActiveSupport::Concern
  included do
    prepend RailsTaxon::Node
    acts_as_list
    
    attr_accessor :take_stock
    has_many :parts, dependent: :nullify
  end
  
end
