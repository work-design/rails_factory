class Factory::Admin::ProductionsController < Factory::Admin::BaseController
  before_action :set_product
  before_action :set_production, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:product_id, :product_plan_id)
    @productions = @product.productions.default_where(q_params).page(params[:page])
  end

  def new
    @production = @product.productions.build
  end

  def create
    @production = @product.productions.build(production_params)

    unless @production.save
      render :new, locals: { model: @production }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @production.assign_attributes(production_params)

    unless @production.save
      render :edit, locals: { model: @production }, status: :unprocessable_entity
    end
  end

  def destroy
    @production.destroy
  end

  private
  def set_product
    @product = Product.find params[:product_id]
  end

  def set_production
    @production = @product.productions.find(params[:id])
  end

  def production_params
    params.fetch(:production, {}).permit(
      :name,
      :state,
      :qr_code,
      :cost_price,
      :profit_price,
      :default,
      :ordered_at
    )
  end

end
