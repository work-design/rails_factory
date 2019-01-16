class CustomPart < ApplicationRecord

  attribute :original_price, :decimal, default: 0

  belongs_to :custom
  belongs_to :part


  before_save :sync_amount

  def sync_amount
    self.original_price = part.price
  end

end unless RailsFactory.config.disabled_models.include?('CustomPart')
