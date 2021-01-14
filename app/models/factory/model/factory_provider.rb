module Factory
  module Model::FactoryProvider
    extend ActiveSupport::Concern

    included do
      belongs_to :factory_taxon
      belongs_to :provider, class_name: 'Organ'

      validates :provider_id, uniqueness: { scope: :factory_taxon_id }
    end

  end
end
