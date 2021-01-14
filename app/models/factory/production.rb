module Factory
  class Production < ApplicationRecord
    include Model::Production
    include RailsTrade::Good
  end
end
