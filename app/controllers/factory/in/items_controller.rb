module Factory
  class In::ItemsController < Trade::In::ItemsController
    before_action :set_item, only: [:show, :edit_assign]

    def edit_assign
      @providers = current_organ.providers
    end

  end
end
