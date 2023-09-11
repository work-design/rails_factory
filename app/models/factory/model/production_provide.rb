module Factory
  module Model::ProductionProvide
    extend ActiveSupport::Concern

    included do
      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :provider, class_name: 'Org::Organ'

      belongs_to :product
      belongs_to :production
      belongs_to :upstream_product, class_name: 'Product'  # 对应供应链产品
      belongs_to :upstream_production, class_name: 'Production'  # 对应供应链产品型号


      has_many :downstream_products, class_name: 'Product', foreign_key: :upstream_product_id
      has_many :downstream_productions, class_name: 'Production', foreign_key: :upstream_production_id

      #before_validation :sync_from_upstream, if: -> { upstream_id_changed? }

    end

  end
end
