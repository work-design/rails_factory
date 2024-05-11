module Factory
  module Model::ProductPartTaxon
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :min_select, :integer, default: 1
      attribute :max_select, :integer
      attribute :product_parts_count, :integer, default: 0

      belongs_to :product
      belongs_to :part_taxon, class_name: 'ProductTaxon'
      has_many :product_parts, ->(o){ where(part_taxon_id: o.part_taxon_id) }, primary_key: :product_id, foreign_key: :product_id, inverse_of: :product_part_taxon
      has_many :parts, through: :product_parts

      validates :min_select, numericality: { only_integer: true, less_than_or_equal_to: -> (o) { o.max_select } }
      #validates :max_select, numericality: { only_integer: true, less_than_or_equal_to: -> (o) { o.product_parts_count } }

      before_validation :sync_name, if: -> { product_id_changed? }
    end

    def sync_name
      #self.name = part_taxon.name
    end



  end
end
