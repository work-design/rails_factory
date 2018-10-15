class Factory::Admin::ProductPlansController < Factory::Admin::BaseController
  before_action :set_product
  before_action :set_product_plan, only: [:show, :edit, :update, :destroy]

  def index
    @product_plans = ProductPlan.page(params[:page])
  end

  def new
    @product_plan = @product.product_plans.build
  end

  def create
    @product_plan = @product.product_plans.build(product_plan_params)

    if @product_plan.save
      redirect_to admin_product_plans_url(@product), notice: 'Product plan was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @product_plan.update(product_plan_params)
      redirect_to admin_product_plans_url(@product), notice: 'Product plan was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @product_plan.destroy
    redirect_to admin_product_plans_url(@product), notice: 'Product plan was successfully destroyed.'
  end

  private
  def set_product
    @product = Product.find params[:product_id]
  end

  def set_product_plan
    @product_plan = ProductPlan.find(params[:id])
  end

  def product_plan_params
    params.fetch(:product_plan, {}).permit(
      :start_at,
      :finish_at,
      :state,
      :planned_count,
    )
  end

end
