module Factory
  class In::HomeController < In::BaseController
    skip_before_action :require_member, only: [:organs]
    def index
    end

    def organs
      @organs = current_account.organs.includes(:organ_domains)
    end

  end
end
