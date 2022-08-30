module Factory
  module Model::Part
    extend ActiveSupport::Concern

    included do
      has_many :product_parts, dependent: :destroy_async
      has_many :products, through: :product_parts
      has_many :part_plans, dependent: :destroy_async
      has_many :part_items, dependent: :destroy_async
      has_many :part_providers, dependent: :destroy_async

      before_save :sync_price
      after_update :sync_part_taxon_id_to_pp, if: -> { saved_change_to_part_taxon_id? }
    end

    private
    def sync_part_taxon_id_to_pp
      self.product_parts.update_all(part_taxon_id: self.part_taxon_id)
    end

    def sync_price
      self.price = self.import_price.to_d + self.profit_price.to_d
    end

  end
end
