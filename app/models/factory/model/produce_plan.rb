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

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      has_many :trade_items, class_name: 'Trade::TradeItem'

      belongs_to :scene
      has_one :specialty_production_plan, ->(o){ where(produce_on: o.produce_on, specialty: true) }, class_name: 'ProductionPlan', foreign_key: :scene_id, primary_key: :scene_id, dependent: :nullify
      has_one :specialty_production, through: :specialty_production_plan, source: :production
      has_many :production_plans, ->(o){ where(produce_on: o.produce_on) }, foreign_key: :scene_id, primary_key: :scene_id, dependent: :nullify
      has_many :productions, through: :production_plans
      has_many :products, through: :production_plans

      validates :produce_on, uniqueness: { scope: [:organ_id, :scene_id] }

      after_initialize if: :new_record? do
        self.produce_on ||= Date.tomorrow
        self.organ_id = scene.organ_id if scene
      end
    end

    def next_plan
      self.class.find_by(organ_id: self.organ_id, scene_id: self.scene_id, produce_on: produce_on + 1)
    end

    def prev_plan
      produce_on - 1 >= Date.today && self.class.find_by(organ_id: self.organ_id, scene_id: self.scene_id, produce_on: produce_on - 1)
    end

  end
end
