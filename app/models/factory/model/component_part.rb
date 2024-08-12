module Factory
  module Model::ComponentPart
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean, default: false

      belongs_to :component, counter_cache: true
      belongs_to :part, class_name: 'Production'

      validates :part_id, uniqueness: { scope: :component_id }
    end

  end
end
