module Factory
  module Model::FactoryTaxon
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer

      has_many :factory_providers, dependent: :delete_all
      has_many :providers, through: :factory_providers
      has_many :product_taxons, ->(o) { where(organ_id: o.provider_ids) }, dependent: :nullify
      has_many :products, through: :product_taxons
    end

  end
end
