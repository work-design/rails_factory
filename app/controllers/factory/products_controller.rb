class Factory::ProductsController < Factory::BaseController
  before_action :set_product_taxon
  before_action :set_product, only: [:show, :edit, :update]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:product_taxon_id, 'name-like')
    @products = Product.default_where(q_params).page(params[:page])
  end

  def show
    @custom = Custom.find_or_create_by(product_id: @product.id)
  end

  def edit
  end

  def update
    @product.assign_attributes(product_params)

    if @product.save
      render 'update'
    else
      render :edit, locals: { model: @product }, status: :unprocessable_entity
    end
  end

  private
  def set_product
    @product = Product.find(params[:id])
  end

  def set_product_taxon
    @product_taxon = ProductTaxon.find params[:product_taxon_id] if params[:product_taxon_id]
  end

  def product_params
    params.fetch(:product, {}).permit(
    )
  end

end
