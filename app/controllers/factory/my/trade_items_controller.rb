module Factory
  class My::TradeItemsController < Trade::My::TradeItemsController
    before_action :set_production

    private
    def set_production
      @production = @trade_item.good
    end
  end
end
