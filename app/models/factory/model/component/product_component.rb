module Factory
  module Model::ProductComponent
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :min_select, :integer, default: 1
      attribute :max_select, :integer
      attribute :product_parts_count, :integer, default: 0

      belongs_to :product, optional: true
      belongs_to :part_taxon, class_name: 'Taxon'

      has_many :product_parts
      has_many :parts, through: :product_parts

      validates :min_select, numericality: { only_integer: true, less_than_or_equal_to: -> (o) { o.max_select } }
      #validates :max_select, numericality: { only_integer: true, less_than_or_equal_to: -> (o) { o.product_parts_count } }

      before_validation :sync_taxon_id, if: -> { product_id_changed? }
    end

    def sync_taxon_id
      self.taxon_id = product.taxon_id
    end



  end
end
