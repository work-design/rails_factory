module Factory
  class Admin::ProvidesController < Admin::BaseController

    def search
      @organs = Org::Organ.default_where('name-like': params['name-like'])
    end

  end
end
