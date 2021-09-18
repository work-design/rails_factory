module Factory
  class Production < ApplicationRecord
    include Model::Production
    include Trade::Model::Good if defined? RailsTrade
  end
end
