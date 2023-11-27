module Factory
  class In::ItemsController < Trade::In::ItemsController
    before_action :set_item, only: [:show, :edit_assign, :update_assign]
    before_action :set_cart_item, only: [:update, :destroy]

    def edit_assign
      upstream_organ_ids = @item.purchase.upstream_provides.pluck(:provider_id)
      @providers = current_organ.providers.where.not(id: upstream_organ_ids)
    end

    def update_assign
      @item.assign_attribute item_params
      @item.save
    end

    private
    def item_params
      params.fetch(:item, {}).permit(
        :organ_id
      )
    end

  end
end
