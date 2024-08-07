module Factory
  module Ext::Organ
    extend ActiveSupport::Concern

    included do
      attribute :invite_token, :string
      attribute :production_enabled, :boolean
      attribute :factory_settings, :json, default: {}

      has_many :factory_providers, class_name: 'Factory::FactoryProvider', foreign_key: :provider_id, dependent: :destroy_async

      has_many :provides, class_name: 'Factory::Provide', dependent: :destroy_async
      has_many :providers, through: :provides
      belongs_to :invite_provide, class_name: 'Factory::Provide', foreign_key: :invite_token, primary_key: :invite_token, optional: true

      after_create :sync_provide_provider_id, if: -> { invite_token.present? && saved_change_to_invite_token? }
    end

    def dispatch
      factory_settings.fetch('dispatch', 'delivery')
    end

    def dispatch_i18n
      Trade::Item.enum_i18n(:dispatch, dispatch)
    end

    def name_detail
      "#{name} (#{id})"
    end

    def nearest_produce_plans
      Factory::ProducePlan.includes(:scene).default_where(organ_id: self.id).effective.order(produce_on: :asc)
    end

    def sync_provide_provider_id
      invite_provide.update(provider_id: self.id)
    end

    def init_provider
      ft = Factory::FactoryTaxon.first
      pt = ft.taxons.build(organ_id: id)
      pt.scene_id = ft.scene_id
      pt.name = ft.name
      pt.provides.build(provider_id: 1)
      pt.save
      pt
    end

  end
end
