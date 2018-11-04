class Factory::My::GoodProvidersController < Factory::My::BaseController
  before_action :set_provider
  before_action :set_good_provider, only: [:show, :edit, :update, :destroy]

  def index
    @good_providers = @provider.good_providers
  end

  def new
    #@good = Facilitate.find params[:facilitate_id]
    @good_provider = @provider.good_providers.build(good_id: params[:good_id], good_type: params[:good_type])
  end

  def create
    @good_provider = @provider.good_providers.build(good_provider_params)

    respond_to do |format|
      if @good_provider.save
        format.html { redirect_to my_good_provider_url(@good_provider), notice: 'Facilitate provider was successfully created.' }
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

  def update
    respond_to do |format|
      if @good_provider.update(good_provider_params)
        format.html { redirect_to my_good_providers_url, notice: 'Facilitate provider was successfully updated.' }
        format.json { render :show, status: :ok, location: @good_provider }
      else
        format.html { render :edit }
        format.json { render json: @good_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @good_provider.destroy
    respond_to do |format|
      format.html { redirect_to my_good_providers_url, notice: 'Facilitate provider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_provider
    @provider = current_user.provider
  end

  def set_good_provider
    @good_provider = GoodProvider.find(params[:id])
  end

  def good_provider_params
    params.fetch(:good_provider, {}).permit(:good_type, :good_id, :export_price)
  end

  def pipeline_params
    params.fetch(:pipeline, {}).permit(:name, :description)
  end

end
