module RailsFactory::Custom
  extend ActiveSupport::Concern
  included do
    attribute :price, :decimal, default: 0
  
    belongs_to :product, optional: true
    belongs_to :cart, optional: true
    belongs_to :buyer, polymorphic: true
    has_many :custom_parts, dependent: :destroy
    has_many :parts, through: :custom_parts
  
    after_initialize if: :new_record? do
      if product_id && part_ids.blank?
        self.part_ids = product.part_ids
      end
      self.organ_id = product.organ_id if defined? :organ_id
    end
    before_validation :compute_sum
  end

  def compute_sum
    self.custom_parts.each(&:sync_amount)
    self.price = custom_parts.sum(&:price)
  end

end
