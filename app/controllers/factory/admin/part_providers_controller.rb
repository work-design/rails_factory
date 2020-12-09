class Factory::Admin::PartProvidersController < Factory::Admin::BaseController
  before_action :set_part
  before_action :set_part_provider, only: [:show, :edit, :select, :update, :destroy]

  def index
    q_params = {}
    q_params.merge! params.permit(:good_type, :good_id)

    @part_providers = GoodProvider.default_where(q_params).order(id: :asc).page(params[:page])
  end

  def new
    @part_provider = @facilitate.part_providers.build
  end

  def create
    @part_provider = @facilitate.part_providers.build(part_provider_params)

    unless @crowd.save
      render :new, locals: { model: @part_provider }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def select
    if part_provider_params[:selected] == 'true'
      @part_provider.set_selected
    else
      @part_provider.update(part_provider_params)
    end

    head :no_content
  end

  def update
    @part_provider.assign_attributes(part_provider_params)

    unless @part_provider.save
      render :edit, locals: { model: @part_provider }, status: :unprocessable_entity
    end
  end

  def destroy
    @part_provider.destroy
  end

  private
  def set_part
    @part = Part.find params[:part_id]
  end

  def set_part_provider
    @part_provider = @part.part_providers.find(params[:id])
  end

  def part_provider_params
    params.fetch(:part_provider, {}).permit(
      :verified,
      :selected
    )
  end

end
