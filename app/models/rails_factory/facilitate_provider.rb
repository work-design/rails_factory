class FacilitateProvider < ApplicationRecord
  belongs_to :facilitate
  belongs_to :provider

  validates :facilitate_id, uniqueness: { scope: :provider_id }

  scope :verified, -> { where(verified: true) }

  def set_selected
    self.class.transaction do
      self.update(selected: true)
      self.class.where.not(id: self.id).where(facilitate_id: self.facilitate_id).update_all(selected: false)
    end
  end

end
