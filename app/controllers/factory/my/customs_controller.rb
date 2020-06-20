class Factory::My::CustomsController < Factory::My::BaseController
  before_action :set_custom, only: [:show, :edit, :update, :cart, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit(:product_plan_id)
    @customs = current_cart.customs.default_where(q_params).page(params[:page])
  end

  def new
    @custom = current_cart.customs.build
  end

  def create
    if params[:product_plan_id].present?
      @custom = Custom.find_or_initialize_by(product_plan_id: custom_params[:product_plan_id], str_part_ids: custom_params[:str_part_ids])
    else
      @custom = Custom.find_or_initialize_by(product_id: custom_params[:product_id], str_part_ids: custom_params[:str_part_ids])
    end
    custom_cart = @custom.custom_carts.find_or_initialize_by(state: 'init', cart_id: current_cart.id)
    custom_cart.customized_at = Time.current
    @custom.assign_attributes custom_params
    @custom.compute_sum
    custom_cart.class.transaction do
      @custom.save
      custom_cart.save
    end

    if params[:commit].present?
      render 'create', locals: { return_to: my_customs_url(product_plan_id: custom_params[:product_plan_id]) }
    else
      render 'create_price'
    end
  end

  def cart
    trade_item = current_cart.trade_items.find_or_initialize_by(good_id: @custom.id, good_type: 'Custom')
    if trade_item.persisted?
      params[:number] ||= 1
      trade_item.number += params[:number].to_i
    end
    trade_item.status = 'checked'
    trade_item.compute_promote
    trade_item.sum_amount
    trade_item.save

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
      :product_plan_id,
      part_ids: []
    )
    q.fetch(:part_ids, []).map!(&:to_i).sort!
    q.merge! str_part_ids: Array(q[:part_ids]).join(',')
    q
  end

end
