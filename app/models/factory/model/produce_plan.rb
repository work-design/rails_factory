module Factory
  module Model::ProducePlan
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :produce_on, :date
      attribute :serial_number, :integer
      attribute :book_finish_at, :datetime
      attribute :book_start_at, :datetime
      attribute :production_plans_count, :integer, default: 0

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

      after_initialize :set_produce_on, if: :new_record?
      before_validation :compute_book_time, if: -> { (produce_on_changed? || scene_id_changed?) && (produce_on.present? && scene.present?) }
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
      self.book_start_at = scene.compute_book_start_at(produce_on)
      self.book_finish_at = scene.compute_book_finish_at(produce_on)
      self
    end

    def set_produce_on
      self.produce_on ||= (self.class.where(organ_id: organ_id).maximum(:produce_on) || Date.today) + 1
      if scene
        compute_book_time
      end
    end

    def automatic
      product_taxon_ids = scene.product_taxons.where(organ_id: organ_id)
      Factory::Production.where(product_taxon_id: product_taxon_ids, automatic: true).each do |production|
        production.production_plans.find_or_create_by(scene_id: scene_id, produce_on: produce_on)
      end
    end

    class_methods do
      def next_plan(organ_ids:, scene_id:, produce_on:)
        find_by(organ_id: organ_ids, scene_id: scene_id, produce_on: produce_on + 1)
      end

      def prev_plan(organ_ids:, scene_id:, produce_on:)
        produce_on - 1 >= Date.today && find_by(organ_id: organ_ids, scene_id: scene_id, produce_on: produce_on - 1)
      end
    end

  end
end
