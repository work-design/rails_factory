module Factory
  class Buy::BaseController < BuyController

    def self.local_prefixes
      [controller_path, 'factory/base']
    end

  end
end
