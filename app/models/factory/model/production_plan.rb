module Factory
  module Model::ProductionPlan
    extend ActiveSupport::Concern

    included do
      attribute :start_at, :datetime
      attribute :finish_at, :datetime
      attribute :state, :string
      attribute :planned_count, :integer, default: 0
      attribute :produced_count, :integer, default: 0
      attribute :produce_on, :date

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
        #self.assign_attributes produce_plan.attributes.slice('start_at', 'finish_at', 'state')
      end
      before_validation :sync_product, if: -> { production.present? && (production_id_changed? || new_record?) }
    end

    def sync_product
      self.product = production.product
    end

  end
end
