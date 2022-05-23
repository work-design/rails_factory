module Factory
  module Model::Serial
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer
      attribute :products_count, :integer, default: 0

      belongs_to :brand
      has_many :products
    end

  end
end
