class Factory::My::CustomsController < Factory::My::BaseController
  before_action :set_custom, only: [:show, :edit, :update, :destroy]

  def index
    @customs = current_cart.customs.page(params[:page])
  end

  def new
    @custom = current_cart.customs.build
  end

  def create
    @custom = current_cart.customs.build(custom_params)
    @custom.compute_sum

    if params[:commit].present? && @custom.save
      render 'create'
    else
      render 'create_price'
    end
  end
  
  def cart
    redirect_to my_cart_url
  end

  def show
  end

  def edit
    @product = @custom.product
  end

  def update
    @custom.assign_attributes(custom_params)
    @custom.compute_sum
    
    if params[:commit].present? && @custom.save
      render 'update'
    else
      render 'update_price'
    end
  end
  
  def destroy
    @custom.destroy
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
