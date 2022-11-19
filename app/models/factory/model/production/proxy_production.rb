module Factory
  module Model::Production::ProxyProduction
    extend ActiveSupport::Concern

    included do
      belongs_to :provider, class_name: 'Org::Organ', optional: true

      belongs_to :upstream, class_name: 'Production'  # 对应供应链产品型号

      before_save :sync_from_upstream, if: -> { upstream_id_changed? }
    end

    def sync_from_upstream
      self.name = upstream.name
      self.cost_price = upstream.price
      self.provider_id = upstream.organ_id
    end

  end
end
