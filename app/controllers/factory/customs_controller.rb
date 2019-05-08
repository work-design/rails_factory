class Factory::CustomsController < Factory::BaseController
  before_action :set_product
  before_action :set_custom, only: [:show, :edit, :update, :destroy]

  def index
    @customs = Custom.page(params[:page])
  end

  def new
    @custom = Custom.new
  end

  def create
    @custom = Custom.new(custom_params)

    if @custom.save
      redirect_to customs_url
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
      redirect_to customs_url
    else
      render :edit
    end
  end

  def destroy
    @custom.destroy
    redirect_to customs_url
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_custom
    @custom = Custom.find(params[:id])
  end

  def custom_params
    params.fetch(:custom, {}).permit(
    )
  end

end
