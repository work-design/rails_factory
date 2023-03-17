module Factory
  class In::HomeController < In::BaseController
    skip_before_action :require_member, only: [:organs]
    before_action :set_roles, only: [:organs]
    def index
    end

    def organs
      @organs = current_account.organs.includes(:organ_domains)
    end

    private
    def set_roles
      if params[:role_id].present?
        @roles = Roled::OrganRole.visible.where(id: params[:role_id])
      else
        @roles = Roled::OrganRole.visible
      end
    end


  end
end
