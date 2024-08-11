module Factory
  module Model::Component::ProductComponent
    extend ActiveSupport::Concern

    included do
      belongs_to :product, optional: true
    end

  end
end
