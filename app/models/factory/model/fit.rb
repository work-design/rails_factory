module Factory
  module Model::Fit
    extend ActiveSupport::Concern

    included do
      enum grade: {

      }

      belongs_to :product
      belongs_to :production, optional: true
      belongs_to :part_brand  # 适用于品牌
      belongs_to :part_serial, optional: true  # 适用于型号
      belongs_to :part_product, optional: true  # 适用于产品
      belongs_to :part_production, optional: true
    end

  end
end
