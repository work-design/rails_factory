class Factory::Admin::PartsController < Factory::Admin::BaseController
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! default_params
    q_params.merge! params.permit(:name, :provider_id)
    @parts = Part.default_where(q_params).page(params[:page])
  end

  def new
    @part = Part.new
  end

  def create
    @part = Part.new(part_params)

    if @part.save
      redirect_to admin_parts_url
    else
      render :new
    end
  end

  def show
  end

  def edit
  end

  def update
    if @part.update(part_params)
      redirect_to admin_parts_url
    else
      render :edit
    end
  end

  def destroy
    @part.destroy
    redirect_to admin_parts_url
  end

  private
  def set_part
    @part = Part.find(params[:id])
  end

  def part_params
    p = params.fetch(:part, {}).permit(
      :name,
      :qr_prefix,
      :import_price,
      :profit_price,
      :part_taxon_ancestors
    )
    p.merge! default_params
  end

end
