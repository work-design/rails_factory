module Factory
  module Model::ProductionPlan
    extend ActiveSupport::Concern

    included do
      attribute :start_at, :datetime
      attribute :finish_at, :datetime
      attribute :state, :string
      attribute :planned_count, :integer, default: 0
      attribute :production_items_count, :integer, default: 0
      attribute :produce_on, :date
      attribute :specialty, :boolean, default: false, comment: '主推'

      belongs_to :production
      belongs_to :product
      belongs_to :scene, optional: true
      belongs_to :produce_plan, ->(o){ where(produce_on: o.produce_on) }, foreign_key: :scene_id, primary_key: :scene_id, optional: true
      has_many :production_items

      enum state: {
        planned: 'planned',
        producing: 'producing',
        produced: 'produced'
      }

      after_initialize if: :new_record? do
        self.product = production.product
        self.produce_on ||= Date.tomorrow
        #self.assign_attributes produce_plan.attributes.slice('start_at', 'finish_at', 'state')
      end
      after_update :set_specialty, if: -> { specialty? && saved_change_to_specialty? }
    end

    def set_specialty
      self.class.where.not(id: self.id).where(scene_id: self.scene_id, produce_on: self.produce_on).update_all(specialty: false)
    end

  end
end
