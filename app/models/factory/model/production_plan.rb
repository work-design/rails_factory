module Factory
  module Model::ProductionPlan
    extend ActiveSupport::Concern

    included do
      attribute :start_at, :datetime
      attribute :finish_at, :datetime
      attribute :state, :string
      attribute :planned_count, :integer, default: 0
      attribute :produced_count, :integer, default: 0

      belongs_to :production
      belongs_to :scene, optional: true
      has_many :production_items

      enum state: {
        planned: 'planned',
        producing: 'producing',
        produced: 'produced'
      }

      after_initialize if: :new_record? do
        #self.assign_attributes produce_plan.attributes.slice('start_at', 'finish_at', 'state')
      end
    end

  end
end
