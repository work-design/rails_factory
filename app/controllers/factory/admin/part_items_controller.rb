class Factory::Admin::PartItemsController < Factory::Admin::BaseController
  before_action :set_part
  before_action :set_part_item, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}.with_indifferent_access
    if params[:product_plan_id]
      @part_plan = PartPlan.find params[:part_plan_id]
      q_params.merge!('received_at-gte': @part_plan.start_at, 'received_at-lte': @part_plan.finish_at)
    end
    q_params.merge! params.fetch(:q, {}).permit('received_at-gte', 'received_at-lte')

    @part_items = @part.part_items.with_attached_qr_file.default_where(q_params).page(params[:page])
  end

  def new
    @part_item = @part.part_items.build
  end

  def create
    @part_item = @part.part_items.build(part_item_params)

    unless @part_item.save
      render :new, locals: { model: @part_item }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @part_item.assign_attributes(part_item_params)

    unless @part_item.save
      render :edit, locals: { model: @part_item }, status: :unprocessable_entity
    end
  end

  def destroy
    @part_item.destroy
  end

  private
  def set_part
    @part = Part.find params[:part_id]
  end

  def set_part_item
    @part_item = PartItem.find(params[:id])
  end

  def part_item_params
    params.fetch(:part_item, {}).permit(
      :part_id,
      :qr_code,
      :qr_file,
    )
  end

end
