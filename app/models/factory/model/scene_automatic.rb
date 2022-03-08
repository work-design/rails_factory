module Factory
  module Model::SceneAutomatic
    extend ActiveSupport::Concern

    included do
      attribute :advance_days, :integer, default: 1

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :scene
    end

  end
end
