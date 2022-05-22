module Factory
  class Panel::SerialsController < Panel::BaseController
    before_action :set_brand
    before_action :set_serial, only: [:show, :edit, :update, :destroy]
    before_action :set_new_serial, only: [:new, :create]

    def index
      @serials = @brand.serials.page(params[:page])
    end

    private
    def set_brand
      @brand = Brand.find params[:brand_id]
    end

    def set_new_serial
      @serial = @brand.serials.build serial_params
    end

    def set_serial
      @serial = @brand.serials.find params[:id]
    end

    def serial_params
      params.fetch(:serial, {}).permit(
        :name,
        :parent_ancestors
      )
    end

  end
end
