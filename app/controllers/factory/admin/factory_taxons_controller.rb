class Factory::Admin::FactoryTaxonsController < Factory::Admin::BaseController
  before_action :set_factory_taxon, only: [:show, :productions, :edit, :update, :destroy]

  def index
    @factory_taxons = FactoryTaxon.order(position: :asc).page(params[:page])
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
    @products = @factory_taxon.products.page(params[:page])

    q_params = {}
    q_params.merge! 'part.organ_id': current_organ.id if current_organ

    product_ids = @products.pluck(:id)
    @select_ids = PartProvider.default_where(q_params).where(product_id: product_ids).pluck(:product_id)
  end

  def productions
    @productions = Production.default_where(product_id: params[:product_id])
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
