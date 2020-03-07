module RailsFactory::ProducePlan
  extend ActiveSupport::Concern
  included do
    attribute :title, :string
    attribute :start_at, :datetime
    attribute :finish_at, :datetime
    attribute :state, :string

    belongs_to :organ, optional: true
    has_many :product_plans, dependent: :nullify

    enum state: {
      planned: 'planned',
      producing: 'producing',
      produced: 'produced'
    }


  end

end
