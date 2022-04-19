module Factory
  class My::TradeItemsController < Trade::My::TradeItemsController
    before_action :set_production
    before_action :set_card_templates, only: [:create, :update]

    private
    def set_production
      @production = @trade_item.good
    end

    def set_card_templates
      @card_templates = Trade::CardTemplate.default_where(default_params)
    end
  end
end
