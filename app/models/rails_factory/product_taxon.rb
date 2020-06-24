module RailsFactory::ProductTaxon
  extend ActiveSupport::Concern

  included do
    attribute :name, :string
    attribute :position, :integer
    attribute :profit_margin, :decimal, precision: 4, scale: 2

    belongs_to :organ, optional: true

    has_many :products, dependent: :nullify

    has_one_attached :logo

    acts_as_list
  end



end
