module Factory
  module Model::ProductComponent
    extend ActiveSupport::Concern

    included do


      belongs_to :product, optional: true

      has_many :product_parts
      has_many :parts, through: :product_parts


    end





  end
end
