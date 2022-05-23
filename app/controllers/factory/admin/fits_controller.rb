module Factory
  class Admin::FitsController < Admin::BaseController
    before_action :set_product
    before_action :set_fit, only: [:show, :edit, :update, :destroy]
    before_action :set_new_fit, only: [:new, :create]
    before_action :set_productions, :set_brands, only: [:new, :create, :edit, :update]

    def index
      q_params = {}
      q_params.merge! params.permit(:production_id)

      @fits = @product.fits.includes(:production, :part_brand, :part_serial, :part_product, :part_production).default_where(q_params).page(params[:page])
    end

    private
    def set_product
      @product = Product.find params[:product_id]
    end

    def set_fit
      @product.fits.find params[:id]
    end

    def set_new_fit
      @fit = @product.fits.build(fit_params)
    end

    def set_productions
      @productions = @product.productions
    end

    def set_brands
      @brands = Brand.all
    end

    def fit_params
      params.fetch(:fit, {}).permit(
        :production_id,
        :part_brand_id,
        :part_serial_id,
        :part_product_id,
        :part_production_id
      )
    end

  end
end
