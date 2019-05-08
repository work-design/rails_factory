class Factory::My::CustomsController < Factory::My::BaseController
  before_action :set_custom, only: [:show, :edit, :update, :destroy]

  def index
    @customs = Custom.page(params[:page])
  end

  def new
    @custom = Custom.new
  end

  def create
    @custom = Custom.new(custom_params)
    @custom.compute_sum

    if @custom.save
      redirect_to my_customs_url
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
      redirect_to my_customs_url
    else
      render :edit
    end
  end

  def destroy
    @custom.destroy
    redirect_to my_customs_url
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
      :ordered_at
    )
  end

end
