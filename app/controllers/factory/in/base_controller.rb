module Factory
  class In::BaseController < InController


    def require_member(url: url_for(controller: 'factory/in/home', action: 'organs'))
      return if current_member

      redirect_to url
    end

  end
end
