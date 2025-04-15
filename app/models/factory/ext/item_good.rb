module Factory
  module Ext::ItemGood
    extend ActiveSupport::Concern

    included do
      has_one :default_production_provide, ->{ where(default: true) }, class_name: 'Factory::ProductionProvide', primary_key: :good_id, foreign_key: :production_id
      has_many :production_provides, class_name: 'Factory::ProductionProvide', primary_key: :good_id, foreign_key: :production_id

      after_save :decrement_stock_with_ordered, if: -> { saved_change_to_status? && status == 'deliverable' && ['trial', 'ordered'].include?(status_before_last_save) }
      after_save :increment_stock_with_back, if: -> { saved_change_to_status? && ['ordered'].include?(status) && ['deliverable'].include?(status_before_last_save) }
    end

    def decrement_stock_with_ordered
      return unless good && good.respond_to?(:stock)
      good.stock = good.stock.to_d - number
      good.last_stock_log = {
        amount: -number,
        title: '下单减库存',
        source_type: self.base_class_name,
        source_id: id
      }
      good.save
    end

    def increment_stock_with_back
      return unless good && good.respond_to?(:stock)
      good.stock = good.stock.to_d + number
      good.last_stock_log = {
        amount: number,
        title: '问题订单恢复库存',
        source_type: self.base_class_name,
        source_id: id
      }
      good.save
    end

  end
end
