module Factory
  module Model::Scene
    extend ActiveSupport::Concern

    included do
      attribute :title, :string

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :production_plans, dependent: :nullify
    end

  end
end
