module RailsFactory::PartProvider
  extend ActiveSupport::Concern

  included do
    attribute :export_price, :decimal
    attribute :verified, :boolean, default: false
    attribute :selected, :boolean

    belongs_to :part
    belongs_to :provider, class_name: 'Organ'

    validates :part_id, uniqueness: { scope: [:provider_id] }

    scope :verified, -> { where(verified: true) }
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
