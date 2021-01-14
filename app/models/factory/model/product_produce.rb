module Factory
  module Model::ProductProduce
    extend ActiveSupport::Concern

    included do
      attribute :position, :integer
      attribute :start_at, :datetime
      attribute :finish_at, :datetime

      belongs_to :product
      belongs_to :produce

      has_one_attached :picture
    end

  end
end
