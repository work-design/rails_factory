module Factory
  class In::TradeItemsController < In::BaseController
    before_action :set_agent
    before_action :set_trade_item, only: [:show, :toggle, :edit, :update, :destroy]
    before_action :set_new_trade_item, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! params.permit(:good_id)

      @trade_items = current_organ.member_ordered_trade_items.includes(:organ).default_where(q_params).page(params[:page])
    end

    def toggle
      if @trade_item.status_init?
        @trade_item.status = 'checked'
      elsif @trade_item.status_checked?
        @trade_item.status = 'init'
      end

      @trade_item.save
    end

    private
    def set_address
      @address = current_user.principal_addresses.find params[:principal_address_id]
    end

    def set_agent
      @agent = current_member
    end

    def set_new_trade_item
      options = params.permit(:good_type, :good_id, :member_id, :number, :produce_on, :scene_id)

      @trade_item = @agent.get_agent_trade_item(**options.to_h.symbolize_keys)
    end

    def set_trade_item
      @trade_item = Trade::TradeItem.find(params[:id])
    end

    def trade_item_params
      params.fetch(:trade_item, {}).permit(
        :number
      )
    end

  end
end
