module Factory
  class Admin::ProductionsController < Admin::BaseController
    before_action :set_product, except: [:taxon]
    before_action :set_production, only: [
      :show, :edit, :update, :destroy, :actions,
      :part, :price, :cost, :card, :update_card, :wallet, :update_wallet
    ]
    before_action :set_new_production, only: [:new, :create]
    before_action :set_product_taxon, only: [:taxon]
    after_action only: [:update, :update_card, :update_wallet] do
      mark_audits(instance: :@production)
    end

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:product_plan_id)

      @productions = @product.productions.default_where(q_params).order(id: :asc).page(params[:page])
    end

    def taxon
      @productions = @product_taxon.productions.includes(:product).default.order(id: :asc).page(params[:page])
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

    def wallet
      @wallet_templates = Trade::WalletTemplate.default_where(default_params)
    end

    def update_wallet
      @production.wallet_price = wallet_price_params
      @production.save
    end

    def import
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

    def production_params
      params.fetch(:production, {}).permit(
        :name,
        :state,
        :qr_code,
        :cost_price,
        :profit_price,
        :price,
        :default,
        :presell,
        :ordered_at,
        :enabled,
        :automatic,
        :link,
        :stock,
        part_ids: []
      )
    end

    def card_price_params
      r = {}

      params.fetch(:production, {}).fetch(:card_price, []).each do |_, v|
        r.merge! v[:code] => v[:price]
      end

      r
    end

    def wallet_price_params
      r = {}

      params.fetch(:production, {}).fetch(:wallet_price, {}).each do |_, v|
        r.merge! v[:code] => v[:price]
      end

      r
    end

  end
end
