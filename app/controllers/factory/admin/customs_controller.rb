class Factory::Admin::CustomsController < Factory::Admin::BaseController
  before_action :set_product, only: [:index, :new, :create]
  before_action :set_custom, only: [:show, :edit, :update, :destroy]

  def index
    @customs = Custom.page(params[:page])
  end

  def new
    @custom = @product.customs.build
  end

  def create
    @custom = @product.customs.build(custom_params)

    if @custom.save
      redirect_to admin_product_customs_url(@product)
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @custom.update(custom_params)
      redirect_to admin_product_customs_url(@custom.product_id)
    else
      render :edit
    end
  end

  def destroy
    @custom.destroy
    redirect_to admin_product_customs_url(@custom.product_id)
  end

  private
  def set_product
    @product = Product.find params[:product_id]
  end

  def set_custom
    @custom = Custom.find(params[:id])
  end

  def custom_params
    params.fetch(:custom, {}).permit(
      :name,
      :customer,
      :state,
      :qr_code,
      :ordered_at
    )
  end

end
