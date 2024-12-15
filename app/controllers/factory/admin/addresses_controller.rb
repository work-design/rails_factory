module Factory
  class Admin::AddressesController < Admin::BaseController
    before_action :set_production
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
      @addresses = @production.addresses.page(params[:page])
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_address
      @address = Ship::Address.find(params[:id])
    end

    def address_params
      params.fetch(:address, {}).permit(
        :area,
        :detail,
        :contact,
        :tel,
        :post_code,
        :source
      )
    end

  end
end
