module Factory
  module Model::Scene
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :book_start_days, :integer, default: 1
      attribute :book_start_at, :time
      attribute :book_finish_days, :integer, default: 0 # 0 表示当天
      attribute :book_finish_at, :time
      attribute :deliver_start_at, :time
      attribute :deliver_finish_at, :time

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :produce_plans, dependent: :nullify
    end

  end
end
