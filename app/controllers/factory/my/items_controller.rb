module Factory
  class My::ItemsController < Trade::My::ItemsController
    before_action :set_production
    before_action :set_card_templates, only: [:create, :update, :destroy]

    private
    def set_production
      @production = @item.good
    end

    def set_card_templates
      @card_templates = Trade::CardTemplate.default_where(default_params)
    end
  end
end
