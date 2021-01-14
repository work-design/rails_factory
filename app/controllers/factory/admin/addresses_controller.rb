module Factory
  class Admin::AddressesController < Admin::BaseController
    before_action :set_custom
    before_action :set_address, only: [:show, :edit, :update, :destroy]

    def index
      @addresses = @custom.addresses.page(params[:page])
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

    def show
    end

    def edit
    end

    def update
      @address.assign_attributes(address_params)

      unless @address.save
        render :edit, locals: { model: @address }, status: :unprocessable_entity
      end
    end

    def destroy
      @address.destroy
    end

    private
    def set_custom
      @custom = Custom.find params[:custom_id]
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
