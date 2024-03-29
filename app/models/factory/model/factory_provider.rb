module Factory
  module Model::FactoryProvider
    extend ActiveSupport::Concern

    included do
      belongs_to :factory_taxon, counter_cache: true
      belongs_to :provider, class_name: 'Org::Organ'

      validates :provider_id, uniqueness: { scope: :factory_taxon_id }
    end

  end
end
