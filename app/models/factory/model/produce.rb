# 生产工艺
module Factory
  module Model::Produce
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :content, :string

      has_one_attached :logo

      has_many :good_produces
    end

  end
end

