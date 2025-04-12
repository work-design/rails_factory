module Factory
  class Admin::Product::ProvidesController < Admin::Taxon::ProvidesController
    before_action :set_product
    before_action :set_provide, only: [:show, :edit, :update, :destroy, :actions, :invite]
    before_action :set_new_provide, only: [:new, :create]
    before_action :set_new_production_provide, only: [:new]
    skip_before_action :set_taxon

    def index
      @product_provides = @product.product_provides.order(id: :asc)

      except_ids = @product_provides.pluck(:provide_id)
      @provides = Provide.where(default_params).where.not(id: except_ids).page(params[:page])
    end

    private
    def set_product
      @product = Product.find params[:product_id]
    end

    def set_new_production_provide
      @provide.production_provides.build
    end

    def provide_params
      params.fetch(:provide, {}).permit(
        :provider_id,
        :name,
        production_provides_attributes: [:product_id]
      )
    end

  end
end
