module RailsFactory::PartTaxonProvider
  extend ActiveSupport::Concern

  included do
    belongs_to :part_taxon_template
    belongs_to :provider, class_name: 'Organ'

    validates :provider_id, uniqueness: { scope: :part_taxon_template_id }
  end

end
