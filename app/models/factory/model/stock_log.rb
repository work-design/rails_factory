module Factory
  module Model::StockLog
    extend ActiveSupport::Concern

    included do
      attribute :title, :string
      attribute :tag_str, :string
      attribute :amount, :decimal
      attribute :stock, :decimal

      belongs_to :production
      belongs_to :source, polymorphic: true, optional: true

      validates :title, presence: true
    end

  end
end
