class Factory::My::ProductionsController < Factory::My::BaseController
  before_action :set_production, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit(:product_plan_id)
    @productions = current_cart.productions.default_where(q_params).page(params[:page])
  end

  def new
    @production = current_cart.productions.build
  end

  def create
    if params[:product_plan_id].present?
      @production = Custom.find_or_initialize_by(product_plan_id: custom_params[:product_plan_id], str_part_ids: custom_params[:str_part_ids])
    else
      @production = Custom.find_or_initialize_by(product_id: custom_params[:product_id], str_part_ids: custom_params[:str_part_ids])
    end
    custom_cart = @production.custom_carts.find_or_initialize_by(state: 'init', cart_id: current_cart.id)
    custom_cart.customized_at = Time.current
    @production.assign_attributes custom_params
    @production.compute_sum
    custom_cart.class.transaction do
      @production.save
      custom_cart.save
    end

    if params[:commit].present?
      render 'create', locals: { return_to: my_cart_url(product_plan_id: custom_params[:product_plan_id]) }
    else
      render 'create_price'
    end
  end

  def show
  end

  def cart

  end

  def edit
    @product = @production.product
  end

  def update
    @production.assign_attributes(custom_params)
    @production.compute_sum

    if params[:commit].present? && @production.save
      render 'update'
    else
      render 'update_price'
    end
  end

  def destroy
    @production.destroy
  end

  private
  def set_production
    @production = Production.find(params[:id])
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
