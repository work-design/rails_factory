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

    respond_to do |format|
      if @good_provider.save
        format.html { redirect_to @good_provider, notice: 'Facilitate provider was successfully created.' }
        format.json { render :show, status: :created, location: @good_provider }
      else
        format.html { render :new }
        format.json { render json: @good_provider.errors, status: :unprocessable_entity }
      end
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
    respond_to do |format|
      if @good_provider.update(good_provider_params)
        format.js { head :no_content }
        format.html { redirect_to @good_provider, notice: 'Facilitate provider was successfully updated.' }
        format.json { render :show, status: :ok, location: @good_provider }
      else
        format.js { head :no_content }
        format.html { render :edit }
        format.json { render json: @good_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @good_provider.destroy
    respond_to do |format|
      format.html { redirect_to good_providers_url, notice: 'Facilitate provider was successfully destroyed.' }
      format.json { head :no_content }
    end
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
