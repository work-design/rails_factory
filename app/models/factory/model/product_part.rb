module Factory
  module Model::ProductPart
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean, default: false

      belongs_to :product, counter_cache: true
      belongs_to :part, class_name: 'Production'
      belongs_to :product_part_taxon

      validates :part_id, uniqueness: { scope: :product_id }

      before_validation :sync_part_taxon, on: :create
    end

    def sync_part_taxon
      #self.part_taxon_id = self.part.product_taxon_id
    end


  end
end
