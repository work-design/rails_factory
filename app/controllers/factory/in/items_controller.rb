module Factory
  class In::ItemsController < Trade::In::ItemsController
    before_action :set_item, only: [:show, :edit_assign, :update]
    before_action :set_cart_item, only: []

    def edit_assign
      @providers = current_organ.providers
    end

    private
    def item_params
      params.fetch(:item, {}).permit(
        :organ_id
      )
    end

  end
end
