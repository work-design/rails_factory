class Factory::My::CustomsController < Factory::My::BaseController
  before_action :set_custom, only: [:show, :edit, :update, :order, :destroy]

  def index
    @customs = current_cart.customs.page(params[:page])
  end

  def new
    @custom = current_cart.customs.build
  end

  def create
    @custom = current_cart.customs.build(custom_params)
    @custom.compute_sum

    respond_to do |format|
      format.js do
        @custom.save if params[:commit].present?
      end
      format.html do
        if @custom.save
          redirect_to my_customs_url
        else
          render :new
        end
      end
    end
  end

  def show
  end

  def edit
    @product = @custom.product
  end

  def update
    if @custom.update(custom_params)
      redirect_to wx_customs_url
    else
      render :edit
    end
  end

  def order
    order = @custom.generate_order! cart: current_cart
    redirect_to my_orders_url(order_id: order.id)
  end
  
  def destroy
    @custom.destroy
    redirect_to wx_customs_url
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
