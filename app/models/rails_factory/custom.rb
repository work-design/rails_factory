module RailsFactory::Custom
  extend ActiveSupport::Concern
  included do
    attribute :price, :decimal, default: 0
  
    belongs_to :product, optional: true
    belongs_to :customer, polymorphic: true
    has_many :custom_parts, dependent: :destroy
    has_many :parts, through: :custom_parts
  
    after_initialize if: :new_record? do
      if product_id && part_ids.blank?
        self.part_ids = product.part_ids
      end
    end
  end

  def compute_sum(user = nil)
    if user
      self.customer = user
    end

    self.custom_parts.each(&:sync_amount)

    self.price = custom_parts.sum(&:price).to_d
  end

end
