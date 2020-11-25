class Factory::Admin::GoodProvidersController < Factory::Admin::BaseController
  before_action :set_good_provider, only: [:show, :edit, :select, :update, :destroy]

  def index
    q_params = params.permit(:good_type, :good_id)
    @good_providers = GoodProvider.default_where(q_params).order(id: :asc).page(params[:page])
  end

  def new
    @good_provider = @facilitate.good_providers.build
  end

  def create
    @good_provider = @facilitate.good_providers.build(good_provider_params)

    unless @crowd.save
      render :new, locals: { model: @good_provider }, status: :unprocessable_entity
    end
  end

  def show
  end

  def edit
  end

  def select
    if good_provider_params[:selected] == 'true'
      @good_provider.set_selected
    else
      @good_provider.update(good_provider_params)
    end

    head :no_content
  end

  def update
    @good_provider.assign_attributes(good_provider_params)

    unless @good_provider.save
      render :edit, locals: { model: @good_provider }, status: :unprocessable_entity
    end
  end

  def destroy
    @good_provider.destroy
  end

  private
  def set_good_provider
    @good_provider = GoodProvider.find(params[:id])
  end

  def good_provider_params
    params.fetch(:good_provider, {}).permit(
      :verified,
      :selected
    )
  end

end
