module Factory
  class In::ItemsController < Trade::In::ItemsController
    before_action :set_item, only: [:show, :edit_assign, :update_assign]

    def edit_assign
      upstream_organ_ids = @item.purchase.upstream_provides.pluck(:provider_id)
      @providers = current_organ.providers.where.not(id: upstream_organ_ids)
    end

    def update_assign
      @item.assign_attributes organ_item_params
      @item.save
    end

    private
    def set_cart
      if current_cart
        @cart = current_cart
      else
        options = { member_organ_id: current_organ.id }
        options.merge! user_id: nil, member_id: nil
        options.merge! client_id: nil, contact_id: nil
        @cart = Trade::Cart.where(options).find_or_create_by(good_type: 'Factory::Production', aim: 'use')
      end
    end

    def organ_item_params
      params.fetch(:item, {}).permit(
        :organ_id
      )
    end

  end
end
