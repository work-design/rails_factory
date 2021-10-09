module Factory
  class Admin::AddressesController < Admin::BaseController
    before_action :set_production
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
      @addresses = @production.addresses.page(params[:page])
    end

    def new
      @address = Address.new
    end

    def create
      @address = Address.new(address_params)

      unless @address.save
        render :new, locals: { model: @address }, status: :unprocessable_entity
      end
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_address
      @address = Address.find(params[:id])
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
