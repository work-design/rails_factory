class Factory::Panel::ProductTaxonTemplatesController < Factory::Panel::BaseController
  before_action :set_product_taxon_template, only: [:show, :edit, :update, :destroy]

  def index
    @product_taxon_templates = ProductTaxonTemplate.page(params[:page])
  end

  def new
    @product_taxon_template = ProductTaxonTemplate.new
  end

  def create
    @product_taxon_template = ProductTaxonTemplate.new(product_taxon_template_params)

    unless @product_taxon_template.save
      render :new, locals: { model: @product_taxon_template }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def update
    @product_taxon_template.assign_attributes(product_taxon_template_params)

    unless @product_taxon_template.save
      render :edit, locals: { model: @product_taxon_template }, status: :unprocessable_entity
    end
  end

  def destroy
    @product_taxon_template.destroy
  end

  private
  def set_product_taxon_template
    @product_taxon_template = ProductTaxonTemplate.find(params[:id])
  end

  def product_taxon_template_params
    params.fetch(:product_taxon_template, {}).permit(
      :name
    )
  end

end
