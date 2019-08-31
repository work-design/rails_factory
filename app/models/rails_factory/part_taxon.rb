module RailsFactory::PartTaxon
  extend ActiveSupport::Concern
  included do
    attribute :min_select, :integer, default: 1
    attribute :max_select, :integer, default: 1  # 最大同时选择，1则为单选
    
    acts_as_list
    
    attr_accessor :take_stock
    has_many :parts, dependent: :nullify
  end
  
end
