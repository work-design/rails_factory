module Factory
  module Model::ProducePlan
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :produce_on, :date
      attribute :serial_number, :integer

      enum state: {
        planned: 'planned',
        producing: 'producing',
        produced: 'produced'
      }, _default: 'planned'

      belongs_to :scene

      has_many :trade_items, class_name: 'Trade::TradeItem'

      has_many :production_plans, ->(o){ where(produce_on: o.produce_on) }, foreign_key: :scene_id, primary_key: :scene_id, dependent: :nullify
      has_many :productions, through: :production_plans
      has_many :products, through: :production_plans
    end

  end
end
