class PmsAdmin::PartPlansController < PmsAdmin::BaseController
  before_action :set_part
  before_action :set_part_plan, only: [:show, :edit, :update, :destroy]

  def index
    @part_plans = @part.part_plans.page(params[:page])
  end

  def new
    @part_plan = @part.part_plans.build
  end

  def create
    @part_plan = @part.part_plans.build(part_plan_params)

    if @part_plan.save
      redirect_to admin_part_plans_url, notice: 'Part plan was successfully created.'
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @part_plan.update(part_plan_params)
      redirect_to admin_part_plans_url, notice: 'Part plan was successfully updated.'
    else
      render :edit
    end
  end

  def destroy
    @part_plan.destroy
    redirect_to admin_part_plans_url, notice: 'Part plan was successfully destroyed.'
  end

  private
  def set_part
    @part = Part.find params[:part_id]
  end

  def set_part_plan
    @part_plan = PartPlan.find(params[:id])
  end

  def part_plan_params
    params.fetch(:part_plan, {}).permit(
      :part_id,
      :start_at,
      :finish_at,
      :state,
      :purchased_count,
    )
  end

end