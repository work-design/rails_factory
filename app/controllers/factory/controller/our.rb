module Factory
  module Controller::Our
    extend ActiveSupport::Concern

    included do
      before_action :require_client
    end

  end
end
