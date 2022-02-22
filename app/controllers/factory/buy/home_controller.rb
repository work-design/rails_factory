module Factory
  class Buy::HomeController < Buy::BaseController

    def index
      @produce_on = Date.today
    end

  end
end
