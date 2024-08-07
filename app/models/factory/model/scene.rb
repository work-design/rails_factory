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
      attribute :specialty, :boolean, default: false

      has_one_attached :logo

      has_many :produce_plans, dependent: :nullify
      has_many :taxons, dependent: :nullify
      has_many :scene_automatics, dependent: :nullify

      scope :specialty, -> { where(specialty: true) }

      after_update :set_specialty, if: -> { specialty? && saved_change_to_specialty? }
    end

    def set_specialty
      self.class.where.not(id: self.id).update_all(specialty: false)
    end

    def compute_book_start_at(produce_on = Date.today)
      date = produce_on - book_start_days
      book_start_at.change(date.parts)
    end

    def compute_book_finish_at(produce_on = Date.today)
      date = produce_on - book_finish_days
      book_finish_at.change(date.parts)
    end

    def bookable?(produce_on = Date.today)
      compute_book_finish_at(produce_on) > Time.current
    end

  end
end
