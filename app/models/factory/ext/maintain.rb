module Factory
  module Ext::Maintain
    extend ActiveSupport::Concern

    included do
      attribute :vendor, :boolean
    end

  end
end
