module Factory
  module Model::FactoryTaxon
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer
      attribute :factory_providers_count, :integer

      belongs_to :scene, optional: true

      has_many :factory_providers, dependent: :delete_all
      has_many :providers, through: :factory_providers
      has_many :products, ->(o) { where(organ_id: o.provider_ids) }
      has_many :productions, through: :products, source: :productions
      has_many :product_taxons

      has_one_attached :logo
    end

  end
end
