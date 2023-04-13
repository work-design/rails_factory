module Factory
  module Controller::Mem
    extend ActiveSupport::Concern
    
    included do
      before_action :require_client
    end
  end
end
