module Factory
  class Admin::ProductionsController < Admin::BaseController
    before_action :set_product
    before_action :set_production, only: [
      :show, :edit, :update, :destroy, :actions,
      :part, :price, :card, :update_card
    ]
    before_action :set_new_production, only: [:new, :create]
    before_action :set_provide_production, only: [:provide]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:product_plan_id)

      @productions = @product.productions.default_where(q_params).order(id: :asc).page(params[:page])
    end

    def detect
    end

    def part
    end

    def price
    end

    def card
      @card_templates = Trade::CardTemplate.default_where(default_params)
    end

    def update_card
      @production.card_price = card_price_params
      @production.save
    end

    def import

    end

    def provide
      part = @production.provided_parts.build
      part.organ_id = current_organ.id
      part.name = @production.name
      part.part_taxon_id = params[:part_taxon_id]

      part.save
    end

    private
    def set_product_taxon
      @product_taxon = ProductTaxon.default_where(default_params).find params[:product_taxon_id]
    end

    def set_product
      @product = Product.default_where(default_params).find params[:product_id]
    end

    def set_production
      @production = @product.productions.find(params[:id])
    end

    def set_new_production
      @production = @product.productions.build production_params
    end

    def set_provide_production
      @production = Production.where(product_id: params[:product_id], id: params[:id]).take
    end

    def production_params
      params.fetch(:production, {}).permit(
        :name,
        :state,
        :qr_code,
        :base_price,
        :profit_price,
        :default,
        :ordered_at,
        :enabled,
        :automatic,
        part_ids: []
      )
    end

    def card_price_params
      r = {}

      params.dig(:production, :card_price).each do |_, v|
        r.merge! v[:code] => v[:price]
      end

      r
    end

  end
end
