module Factory
  module Model::Serial
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :position, :integer

      belongs_to :brand
    end

  end
end
