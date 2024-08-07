module Factory
  module Model::TaxonPart
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean, default: false

      belongs_to :taxon
      belongs_to :taxon_component, counter_cache: true
      belongs_to :part, class_name: 'Production'

      validates :part_id, uniqueness: { scope: :taxon_id }

      after_initialize :sync_taxon, if: :new_record?
    end

    def sync_taxon
      if taxon_component
        self.taxon_id = taxon_component.taxon_id
      end
    end

  end
end
