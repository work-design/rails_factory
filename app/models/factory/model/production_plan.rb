module Factory
  module Model::ProductionPlan
    extend ActiveSupport::Concern

    included do
      attribute :start_at, :datetime
      attribute :finish_at, :datetime
      attribute :produce_on, :date
      attribute :state, :string
      attribute :planned_count, :integer, default: 0
      attribute :production_items_count, :integer, default: 0
      attribute :specialty, :boolean, default: false, comment: '主推'
      attribute :trade_items_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true
      belongs_to :station, class_name: 'Space::Station', optional: true if defined? RailsSpace
      has_many :trade_items, ->(o){ where(good_type: 'Factory::Production', produce_on: o.produce_on) }, class_name: 'Trade::TradeItem', foreign_key: :good_id, primary_key: :production_id

      belongs_to :production
      belongs_to :product
      belongs_to :scene, optional: true
      belongs_to :produce_plan, ->(o){ where(produce_on: o.produce_on, organ_id: o.organ_id) }, foreign_key: :scene_id, primary_key: :scene_id, counter_cache: true, optional: true

      has_many :production_items

      enum :state, {
        planned: 'planned',
        producing: 'producing',
        produced: 'produced'
      }

      after_initialize :init_produce, if: :new_record?
      after_update :set_specialty, if: -> { specialty? && saved_change_to_specialty? }
    end

    def init_produce
      self.product = production.product
      self.organ_id = production.organ_id
      self.produce_on ||= Date.tomorrow
      produce_plan || build_produce_plan
    end

    def set_specialty
      self.class.where.not(id: self.id).where(scene_id: self.scene_id, produce_on: self.produce_on).update_all(specialty: false)
    end

  end
end
