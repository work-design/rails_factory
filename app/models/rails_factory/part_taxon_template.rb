module RailsFactory::PartTaxonTemplate
  extend ActiveSupport::Concern

  included do
    attribute :name, :string

    has_many :part_taxon_providers, dependent: :delete_all
    has_many :providers, through: :part_taxon_providers
  end

end
