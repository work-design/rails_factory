module Factory
  class In::ItemsController < Trade::In::ItemsController
    before_action :set_cart, :set_item, only: [:show, :edit_assign, :update_assign]

    def edit_assign
      upstream_organ_ids = @item.purchase.production_provides.pluck(:provider_id)
      @providers = current_organ.providers.where.not(id: upstream_organ_ids)
    end

    def update_assign
      @item.assign_attributes organ_item_params
      @item.save
    end

    private
    def set_cart
      @cart = Trade::Cart.get_cart(params, member_organ_id: current_organ.id)
    end

    def organ_item_params
      params.fetch(:item, {}).permit(
        :organ_id
      )
    end

  end
end
