module RailsFactory::FactoryTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string

    has_many :factory_providers, dependent: :delete_all
    has_many :providers, through: :factory_providers
  end

end
