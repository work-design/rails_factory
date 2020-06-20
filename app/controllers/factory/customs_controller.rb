class Factory::CustomsController < Factory::BaseController
  before_action :set_product
  before_action :set_custom, only: [:show]

  def index
    @customs = Custom.page(params[:page])
  end

  def show
  end

  private
  def set_product
    @product = Product.find(params[:product_id])
  end

  def set_custom
    @custom = Custom.find(params[:id])
  end

end
