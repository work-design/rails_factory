module Factory
  class In::BaseController < InController
    include Controller::In

    def self.local_prefixes
      [controller_path, 'factory/base']
    end

  end
end
