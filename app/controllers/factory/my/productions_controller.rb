module Factory
  class My::ProductionsController < My::BaseController
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
      r = production_params.fetch(:part_ids, []).reject(&:blank?).map!(&:to_i).sort!
      @production = Production.find_or_initialize_by(product_id: production_params[:product_id], str_part_ids: r.join(','))
      @production.assign_attributes production_params
      @production.compute_sum
      @production.save!

      if current_cart
        production_cart = @production.production_carts.find_or_initialize_by(state: 'init', cart_id: current_cart.id)
        production_cart.customized_at ||= Time.current
        production_cart.save!
      end

      if params[:commit].present?
        render 'create'
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
      @production.assign_attributes(production_params)
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

    def production_params
      params.fetch(:production, {}).permit(
        :product_id,
        part_ids: []
      )
    end

  end
end
