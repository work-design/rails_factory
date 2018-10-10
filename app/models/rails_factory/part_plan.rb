class PartPlan < ApplicationRecord
  belongs_to :part
  has_many :part_items, ->(o){ default_where('created_at-gte': o.start_at, 'created_at-lt': o.finish_at) }, primary_key: 'part_id', foreign_key: 'part_id'

  enum state: {
    purchased: 'purchased',
    received: 'received'
  }

end
