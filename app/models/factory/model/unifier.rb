module Factory
  module Model::Unifier
    extend ActiveSupport::Concern

    included do
      attribute :name, :string
      attribute :code, :string
    end

  end
end
