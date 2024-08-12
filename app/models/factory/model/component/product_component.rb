module Factory
  module Model::Component::ProductComponent
    extend ActiveSupport::Concern

    included do
      belongs_to :product, optional: true

      before_validation :sync_taxon_id, if: -> { product_id_changed? }
    end

    def sync_taxon_id
      self.taxon_id = product.taxon_id
    end

  end
end
