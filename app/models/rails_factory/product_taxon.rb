module RailsFactory::ProductTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :position, :integer

    belongs_to :organ, optional: true
    belongs_to :product_taxon_template, optional: true

    has_many :products, dependent: :nullify

    has_one_attached :logo

    acts_as_list
  end

end
