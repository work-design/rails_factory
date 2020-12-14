module RailsFactory::PartProvider
  extend ActiveSupport::Concern

  included do
    attribute :export_price, :decimal
    attribute :verified, :boolean, default: false
    attribute :selected, :boolean

    belongs_to :part, inverse_of: :part_providers
    belongs_to :product  # 对应供应链产品
    belongs_to :production  # 对应供应链产品型号
    belongs_to :provider, class_name: 'Organ'

    validates :part_id, uniqueness: { scope: [:provider_id] }

    scope :verified, -> { where(verified: true) }

    before_validation :sync_from_production, if: -> { production && production_id_changed? }
  end

  def sync_from_production
    self.product_id = production.product_id
    self.provider_id = product.organ_id
  end

  def set_selected
    self.class.transaction do
      self.class.where.not(id: self.id).where(part_id: self.part_id).update_all(selected: false)
    end
  end

  def xx
    part.import_price = self.export_price
  end

end
