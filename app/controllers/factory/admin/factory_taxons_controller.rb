module Factory
  class Admin::FactoryTaxonsController < Admin::BaseController
    before_action :set_factory_taxon, only: [:show, :import, :productions, :edit, :update, :destroy]

    def index
      @factory_taxons = FactoryTaxon.order(position: :asc).page(params[:page])
    end

    def show
      @products = @factory_taxon.products.page(params[:page])

      q_params = {}
      q_params.merge! 'part.organ_id': current_organ.id if current_organ

      product_ids = @products.pluck(:id)
      @select_ids = PartProvider.default_where(q_params).where(product_id: product_ids).pluck(:product_id)
    end

    def import
      q_params = {}
      q_params.merge! params.permit(:organ_id)
      @products = @factory_taxon.products.default_where(q_params).page(params[:page])

      product_ids = @products.pluck(:id)
      @select_ids = PartProvider.default_where(default_params).where(product_id: product_ids).pluck(:product_id)
    end

    def productions
      @productions = Production.default_where(product_id: params[:product_id])
    end

    private
    def set_factory_taxon
      @factory_taxon = FactoryTaxon.find(params[:id])
    end

    def factory_taxon_params
      params.fetch(:factory_taxon, {}).permit(
        :name
      )
    end

  end
end
