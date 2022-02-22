module Factory
  module Model::ProducePlan
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :produce_on, :date
      attribute :serial_number, :integer
      attribute :book_finish_at, :datetime
      attribute :book_start_at, :datetime

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

      scope :effective, -> { t = Time.current.to_fs(:db); default_where('book_start_at-lt': t, 'book_finish_at-gt': t) }

      validates :produce_on, uniqueness: { scope: [:organ_id, :scene_id] }

      after_initialize if: :new_record? do
        self.produce_on ||= Date.tomorrow
        if scene
          self.organ_id = scene.organ_id
        end
      end
      before_save :compute_book_time, if: -> { (produce_on_changed? || scene_id_changed?) && (produce_on.present? && scene.present?) }
    end

    def next_plan
      self.class.find_by(organ_id: self.organ_id, scene_id: self.scene_id, produce_on: produce_on + 1)
    end

    def prev_plan
      produce_on - 1 >= Date.today && self.class.find_by(organ_id: self.organ_id, scene_id: self.scene_id, produce_on: produce_on - 1)
    end

    def deliver_start_at
      scene.deliver_start_at.change(produce_on.parts)
    end

    def deliver_finish_at
      scene.deliver_finish_at.change(produce_on.parts)
    end

    def expired?
      Time.current > book_finish_at
    end

    def compute_book_time
      date = produce_on - scene.book_start_days
      self.book_start_at = scene.book_start_at.change(date.parts)

      date = produce_on - scene.book_finish_days
      self.book_finish_at = scene.book_finish_at.change(date.parts)
      self
    end

  end
end
