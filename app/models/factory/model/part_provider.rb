module Factory
  module Model::PartProvider
    extend ActiveSupport::Concern

    included do
      attribute :cost_price, :decimal
      attribute :verified, :boolean, default: false
      attribute :selected, :boolean

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      belongs_to :product, inverse_of: :part_providers, counter_cache: true
      belongs_to :production

      #validates :product_id, uniqueness: { scope: [:provider_id] }

      scope :verified, -> { where(verified: true) }

      before_validation :sync_from_production, if: -> { production && production_id_changed? }
      before_save :sync_to_part, if: -> { production && production_id_changed? }
      #after_save :sync_price_to_part, if: -> { selected? && saved_change_to_selected? }
    end

    def sync_from_production
      self.upstream_product_id = upstream_production.product_id
      self.cost_price = upstream_production.price
      self.provider_id = upstream_product.organ_id
      self.product ||= production.product
      self.organ = production.organ || product.organ
    end

    def sync_to_part
      #part.name = production.name
    end

    def set_selected
      self.class.transaction do
        self.class.where.not(id: self.id).where(part_id: self.part_id).update_all(selected: false)
      end
    end

    def sync_price_to_part
      part.import_price = self.cost_price
      part.save
    end

  end
end
