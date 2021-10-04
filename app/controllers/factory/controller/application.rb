module Factory
  module Controller::Application

    def current_cart
      return @current_cart if @current_cart

      if current_user
        cart = current_user.carts.find_or_create_by(default_form_params)
        @current_cart = Cart.find cart.id
      end
      logger.debug "\e[35m  Current Factory cart: #{@current_cart&.id}  \e[0m"
      @current_cart
    end

  end
end
