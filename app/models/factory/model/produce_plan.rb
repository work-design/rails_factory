module Factory
  module Model::ProducePlan
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :start_at, :datetime
      attribute :finish_at, :datetime

      enum state: {
        planned: 'planned',
        producing: 'producing',
        produced: 'produced'
      }, _default: 'planned'

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :product_plans, dependent: :nullify
    end

  end
end
