module RailsFactoryExt::Customable
  extend ActiveSupport::Concern

  included do
    has_many :customs
  end

  def generate_custom(product_id, part_ids)
    custom = self.customs.build(product_id: product_id)
    custom
  end

end
