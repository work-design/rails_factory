module Factory
  module Model::ProductHost
    extend ActiveSupport::Concern

    included do
      attribute :profit_margin, :decimal, precision: 4, scale: 2, default: 0
      attribute :min_price, :decimal
      attribute :max_price, :decimal

      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :product

      has_many :productions, ->(o) { where(organ_id: o.organ_id) }, primary_key: :product_id, foreign_key: :product_id
    end

    def profit_margin_str
      (profit_margin.to_d * 100).to_fs(:percentage)
    end

  end
end
