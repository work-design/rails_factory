module Factory
  module Ext::ItemGood
    extend ActiveSupport::Concern

    included do
      after_save :decrement_stock_with_ordered, if: -> { saved_change_to_status? && status == 'deliverable' && ['trial', 'ordered'].include?(status_before_last_save) }
      after_save :increment_stock_with_back, if: -> { saved_change_to_status? && ['ordered'].include?(status) && ['deliverable'].include?(status_before_last_save) }
    end

    def decrement_stock_with_ordered
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
