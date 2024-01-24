module Factory
  module Model::ProductionProvide
    extend ActiveSupport::Concern

    included do
      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :provider, class_name: 'Org::Organ'

      belongs_to :product_taxon
      belongs_to :product
      belongs_to :production
      belongs_to :upstream_product, class_name: 'Product'  # 对应供应链产品
      belongs_to :upstream_production, class_name: 'Production'  # 对应供应链产品型号

      has_many :downstream_products, class_name: 'Product', foreign_key: :upstream_product_id
      has_many :downstream_productions, class_name: 'Production', foreign_key: :upstream_production_id

      has_many :brothers, class_name: self.name, primary_key: :upstream_product_id, foreign_key: :upstream_product_id, validate: false

      before_validation :sync_from_upstream, if: :new_record?
      after_destroy :prune
    end

    def sync_from_upstream
      self.upstream_product = upstream_production.product
      self.provider_id = upstream_production.organ_id

      if product.nil? && brothers.present?
        self.product = brothers.find(&:product).product
      else
        build_product
      end
      product.product_taxon = product_taxon
      product.name = upstream_product.name
      product.logo.attach upstream_product.logo_blob

      production || build_production
      production.product = product
      production.name = upstream_production.name
      production.cost_price = upstream_production.price
    end

    def prune
      if brothers.pluck(:id) == [id]
        product.destroy
      end
    end

  end
end
