module Factory
  module Model::ProductionProvide
    extend ActiveSupport::Concern

    included do
      belongs_to :upstream, class_name: 'Production'  # 对应供应链产品型号
      belongs_to :provider, class_name: 'Org::Organ', optional: true

      has_many :downstreams, class_name: 'ProxyProduction', foreign_key: :upstream_id

      #before_validation :sync_from_upstream, if: -> { upstream_id_changed? }

    end

  end
end
