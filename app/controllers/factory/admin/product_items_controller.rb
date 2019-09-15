class Factory::Admin::ProductItemsController < Factory::Admin::BaseController
  before_action :set_product
  before_action :set_product_item, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}.with_indifferent_access
    if @product_plan
      q_params.merge!('produced_at-gte': @product_plan.start_at, 'produced_at-lte': @product_plan.finish_at)
    end
    q_params.merge! params.fetch(:q, {}).permit('produced_at-gte', 'produced_at-lte')

    @product_items = @product.product_items.with_attached_qr_file.default_where(q_params).page(params[:page])
  end

  def new
    @product_item = @product.product_items.build
  end

  def create
    @product_item = @product.product_items.build(product_item_params)

    unless @product_item.save
      render :new, locals: { model: @product_item }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @product_item.assign_attributes(product_item_params)

    unless @product_item.save
      render :edit, locals: { model: @product_item }, status: :unprocessable_entity
    end
  end

  def destroy
    @product_item.destroy
  end

  private
  def set_product
    @product = Product.find params[:product_id]
    if params[:product_plan_id]
      @product_plan = ProductPlan.find params[:product_plan_id]
    end
  end

  def set_product_item
    @product_item = ProductItem.find(params[:id])
  end

  def product_item_params
    params.fetch(:product_item, {}).permit(
      :product_id,
      :qr_code,
      :qr_file,
      :produced_at
    )
  end

end
