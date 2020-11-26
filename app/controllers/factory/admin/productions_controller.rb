class Factory::Admin::ProductionsController < Factory::Admin::BaseController
  before_action :set_product, only: [:index]
  before_action :set_production, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:product_id, :product_plan_id)
    @productions = production.default_where(q_params).page(params[:page])
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
    if params[:product_id]
      @product = Product.find params[:product_id]
    elsif params[:product_plan_id]
      @product_plan = ProductPlan.find params[:product_plan_id]
      @product = @product_plan.product
    end
  end

  def set_production
    @production = production.find(params[:id])
  end

  def production_params
    params.fetch(:production, {}).permit(
      :name,
      :state,
      :qr_code,
      :ordered_at
    )
  end

end
