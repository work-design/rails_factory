module Factory
  class Panel::FactoryTaxonsController < Panel::BaseController
    before_action :set_factory_taxon, only: [:show, :edit, :update, :destroy]

    def index
      @factory_taxons = FactoryTaxon.page(params[:page])
    end

    def new
      @factory_taxon = FactoryTaxon.new
    end

    def create
      @factory_taxon = FactoryTaxon.new(factory_taxon_params)

      unless @factory_taxon.save
        render :new, locals: { model: @factory_taxon }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @factory_taxon.assign_attributes(factory_taxon_params)

      unless @factory_taxon.save
        render :edit, locals: { model: @factory_taxon }, status: :unprocessable_entity
      end
    end

    def destroy
      @factory_taxon.destroy
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
