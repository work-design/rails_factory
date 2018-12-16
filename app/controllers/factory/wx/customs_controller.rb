class Factory::Wx::CustomsController < Factory::Wx::BaseController
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
      redirect_to wx_customs_url, notice: 'Custom was successfully created.'
    else
      render :new
    end
  end

  def update_price
    @total_price = '222'
  end

  def show
  end

  def edit
  end

  def update
    if @custom.update(custom_params)
      redirect_to wx_customs_url, notice: 'Custom was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @custom.destroy
    redirect_to wx_customs_url, notice: 'Custom was successfully destroyed.'
  end

  private
  def set_custom
    @custom = Custom.find(params[:id])
  end

  def custom_params
    params.fetch(:custom, {}).permit(
    )
  end

end
