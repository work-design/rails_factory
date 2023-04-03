module Factory
  class Production < ApplicationRecord
    include Model::Production
    include Trade::Ext::Good if defined? RailsTrade

    paginates_per 10
  end
end
