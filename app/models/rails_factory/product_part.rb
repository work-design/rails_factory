class ProductPart < ApplicationRecord
  belongs_to :product
  belongs_to :part

end
