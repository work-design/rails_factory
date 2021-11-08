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

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_one_attached :logo

      has_many :produce_plans, dependent: :nullify
      has_many :product_taxons, dependent: :nullify

      scope :specialty, -> { where(specialty: true) }

      after_update :set_specialty, if: -> { specialty? && saved_change_to_specialty? }
    end

    def set_specialty
      self.class.where.not(id: self.id).where(organ_id: self.organ_id).update_all(specialty: false)
    end

  end
end
