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
    @custom.compute_sum(current_user)

    respond_to do |format|
      format.js do
        @custom.save if params[:commit].present?
      end
      format.html do
        if @custom.save
          redirect_to wx_customs_url, notice: 'Custom was successfully created.'
        else
          render :new
        end
      end
    end
  end

  def price
    @custom = Custom.new(custom_params)
    @custom.compute_sum
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
    q = params.fetch(:custom, {}).permit(
      :product_id,
      part_ids: []
    )
    q.fetch(:part_ids, []).map!(&:to_i)
    q
  end

end
