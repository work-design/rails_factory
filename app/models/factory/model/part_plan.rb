module Factory
  module Model::PartPlan
    extend ActiveSupport::Concern

    included do
      attribute :start_at, :datetime
      attribute :finish_at, :datetime
      attribute :state, :string
      attribute :purchased_count, :integer, default: 0
      attribute :received_count, :integer, default: 0

      belongs_to :part
      belongs_to :product, optional: true
      belongs_to :production, optional: true
      has_many :part_items, ->(o){ default_where('created_at-gte': o.start_at, 'created_at-lt': o.finish_at) }, primary_key: 'part_id', foreign_key: 'part_id'

      enum :state, {
        purchased: 'purchased',
        received: 'received'
      }
    end

  end
end
