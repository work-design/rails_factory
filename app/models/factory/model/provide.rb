module Factory
  module Model::Provided
    extend ActiveSupport::Concern

    included do
      belongs_to :organ, class_name: 'Org::Organ'
      belongs_to :provider, class_name: 'Org::Organ'
    end

  end
end
