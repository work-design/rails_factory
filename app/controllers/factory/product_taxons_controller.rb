class Factory::ProductTaxonsController < Factory::BaseController
  before_action :set_product_taxon, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    @product_taxons = ProductTaxon.default_where(q_params).page(params[:page])
  end

  def new
    @product_taxon = ProductTaxon.new
  end

  def create
    @product_taxon = ProductTaxon.new(product_taxon_params)

    respond_to do |format|
      if @product_taxon.save
        format.html.phone
        format.html { redirect_to _product_taxons_url }
        format.js { redirect_back fallback_location: _product_taxons_url }
        format.json { render :show }
      else
        format.html.phone { render :new }
        format.html { render :new }
        format.js { redirect_back fallback_location: _product_taxons_url }
        format.json { render :show }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    @product_taxon.assign_attributes(product_taxon_params)

    respond_to do |format|
      if @product_taxon.save
        format.html.phone
        format.html { redirect_to _product_taxons_url }
        format.js { redirect_back fallback_location: _product_taxons_url }
        format.json { render :show }
      else
        format.html.phone { render :edit }
        format.html { render :edit }
        format.js { redirect_back fallback_location: _product_taxons_url }
        format.json { render :show }
      end
    end
  end

  def destroy
    @product_taxon.destroy
    redirect_to _product_taxons_url
  end

  private
  def set_product_taxon
    @product_taxon = ProductTaxon.find(params[:id])
  end

  def product_taxon_params
    params.fetch(:product_taxon, {}).permit(
      :name,
      :logo
    )
  end

end
