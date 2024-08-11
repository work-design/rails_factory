module Factory
  module Model::Component::TaxonComponent
    extend ActiveSupport::Concern

    included do
      belongs_to :taxon, counter_cache: true
    end

  end
end
