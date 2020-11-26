class Factory::Admin::ProductPlansController < Factory::Admin::BaseController
  before_action :set_product
  before_action :set_product_plan, only: [:show, :edit, :update, :destroy]
  before_action :prepare_form, only: [:new, :edit]

  def index
    @product_plans = @product.product_plans.order(id: :desc).page(params[:page])
  end

  def new
    @product_plan = @product.product_plans.build
  end

  def create
    @product_plan = @product.product_plans.build(product_plan_params)

    unless @product_plan.save
      render :new, locals: { model: @product_plan }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @product_plan.assign_attributes(product_plan_params)

    unless @product_plan.save
      render :edit, locals: { model: @product_plan }, status: :unprocessable_entity
    end
  end

  def destroy
    @product_plan.destroy
  end

  private
  def set_product
    @product = Product.find params[:product_id]
  end

  def set_product_plan
    @product_plan = ProductPlan.find(params[:id])
  end

  def prepare_form
    @produce_plans = ProducePlan.default_where(default_params)
  end

  def product_plan_params
    params.fetch(:product_plan, {}).permit(
      :produce_plan_id,
      :start_at,
      :finish_at,
      :state,
      :planned_count
    )
  end

end
