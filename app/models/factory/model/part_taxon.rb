module Factory
  module Model::PartTaxon
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer
      attribute :take_stock, :boolean, comment: '可盘点'
      attribute :parts_count, :integer, default: 0

      belongs_to :organ, optional: true
      belongs_to :factory_taxon, optional: true
      has_many :parts, dependent: :nullify

      acts_as_list
    end

  end
end
