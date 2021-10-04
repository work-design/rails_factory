module Factory
  module Model::User
    extend ActiveSupport::Concern

    included do
      has_many :productions, dependent: :destroy_async
    end

  end
end
