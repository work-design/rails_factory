module Factory
  module Model::Fit
    extend ActiveSupport::Concern

    included do
      enum :grade, {
        primary: 'primary'
      }

      belongs_to :product, counter_cache: true
      belongs_to :production, optional: true
      belongs_to :part_brand, class_name: 'Brand'  # 适用于品牌
      belongs_to :part_serial, class_name: 'Serial', optional: true  # 适用于型号
      belongs_to :part_product, class_name: 'Product', optional: true  # 适用于产品
      belongs_to :part_production, class_name: 'Production', optional: true
    end

  end
end
