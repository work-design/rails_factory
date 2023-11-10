module Factory
  class In::ItemsController < Trade::In::ItemsController
    before_action :set_item, only: [:show, :edit_assign, :update]
    before_action :set_cart_item, only: []

    def edit_assign
      upstream_organ_ids = @item.purchase.upstream_provides.pluck(:provider_id)
      @providers = current_organ.providers.where.not(id: upstream_organ_ids)
    end

    private
    def item_params
      params.fetch(:item, {}).permit(
        :organ_id
      )
    end

  end
end
