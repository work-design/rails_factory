module Factory
  class Buy::BaseController < IntoController

    def self.local_prefixes
      [controller_path, 'factory/base']
    end

  end
end
