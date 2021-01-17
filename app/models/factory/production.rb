module Factory
  class Production < ApplicationRecord
    include Model::Production
    include Trade::Model::Good
  end
end
