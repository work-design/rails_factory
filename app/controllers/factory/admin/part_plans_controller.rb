class Factory::Admin::PartPlansController < Factory::Admin::BaseController
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

    unless @part_plan.save
      render :new, locals: { model: @part_plan }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @part_plan.update(part_plan_params)

    unless @part_plan.save
      render :edit, locals: { model: @part_plan }, status: :unprocessable_entity
    end
  end

  def destroy
    @part_plan.destroy
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
