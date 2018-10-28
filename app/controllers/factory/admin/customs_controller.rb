class Factory::Admin::CustomsController < Factory::Admin::BaseController
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
      redirect_to customs_url, notice: 'Custom was successfully created.'
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
      redirect_to customs_url, notice: 'Custom was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @custom.destroy
    redirect_to customs_url, notice: 'Custom was successfully destroyed.'
  end

  private
  def set_custom
    @custom = Custom.find(params[:id])
  end

  def custom_params
    params.fetch(:custom, {}).permit(
      :name,
      :customer,
      :state,
      :qr_code,
      :ordered_at,
    )
  end

end
