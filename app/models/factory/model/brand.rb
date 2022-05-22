module Factory
  module Model::Brand
    extend ActiveSupport::Concern

    included do
      attribute :type, :string
      attribute :name, :string
      attribute :code, :string
      attribute :entities_count, :integer, default: 0

      belongs_to :organ, class_name: 'Org::Organ', optional: true

      has_many :serials, dependent: :destroy_async

      has_one_attached :logo
    end

  end
end
