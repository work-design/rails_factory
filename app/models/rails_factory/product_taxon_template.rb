module RailsFactory::ProductTaxonTemplate
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
  end

end
