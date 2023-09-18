module Factory
  module Ext::Item
    extend ActiveSupport::Concern

    included do
      attribute :produce_on, :date, comment: '对接生产管理'
      attribute :purchase_id, :integer

      enum purchase_status: {
        init: 'init',
        received: 'received'
      }, _prefix: true

      belongs_to :scene, class_name: 'Factory::Scene', optional: true
      belongs_to :produce_plan, ->(o) { where(organ_id: o.organ_id, produce_on: o.produce_on) }, class_name: 'Factory::ProducePlan', foreign_key: :scene_id, primary_key: :scene_id, optional: true  # 产品对应批次号
      belongs_to :production_plan, ->(o) { where(produce_on: o.produce_on, scene_id: o.scene_id) }, class_name: 'Factory::ProductionPlan', foreign_key: :good_id, primary_key: :production_id, counter_cache: :trade_items_count, optional: true
      belongs_to :purchase, polymorphic: true, foreign_type: :good_type, optional: true

      before_validation :sync_from_produce_plan, if: -> { respond_to?(:produce_plan) && produce_plan }
      after_save :increment_stock, if: -> { purchase_status == 'received' && ['init'].include?(purchase_status_before_last_save) }
      after_save :decrement_stock, if: -> { purchase_status != 'received' && ['received'].include?(purchase_status_before_last_save) }
    end

    def sync_from_produce_plan
      self.produce_on = produce_plan.produce_on
      self.expire_at = produce_plan.book_finish_at
    end

    def sync_from_purchase
      return unless purchase
      self.good_name = purchase.name
      self.extra = Hash(self.extra).merge purchase.item_extra
    end

    def increment_stock
      purchase.stock = purchase.stock.to_d + number
      purchase.save
    end

    def decrement_stock
      purchase.stock = purchase.stock.to_d - number
      purchase.save
    end

    def sync_log
      log = self.stock_log || self.build_stock_log
      log.title = self.note.presence || I18n.t('wallet_log.income.wallet_advance.title')
      log.tag_str = I18n.t('wallet_log.income.wallet_advance.tag_str')
      log.amount = self.number
      log.save
    end

  end
end
