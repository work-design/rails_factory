module Factory
  module Model::ComponentPart
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean, default: false

      belongs_to :component, counter_cache: true
      belongs_to :taxon
      belongs_to :product, optional: true
      belongs_to :part, class_name: 'Production'

      validates :part_id, uniqueness: { scope: :component_id }

      before_validation :sync_from_component, if: -> { component_id_changed? }
    end

    def sync_from_component
      self.taxon_id = component.taxon_id
      self.product_id = component.product_id
    end

  end
end
