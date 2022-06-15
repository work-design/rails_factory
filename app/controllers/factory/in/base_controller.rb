module Factory
  class In::BaseController < InController

    def self.local_prefixes
      [controller_path, 'factory/base']
    end

  end
end
