class Factory::My::FacilitateProvidersController < Factory::My::BaseController
  before_action :set_provider
  before_action :set_facilitate_provider, only: [:show, :edit, :update, :destroy]

  def index
    @facilitate_providers = @provider.facilitate_providers
  end

  def new
    @facilitate = Facilitate.find params[:facilitate_id]
    @facilitate_provider = @provider.facilitate_providers.build(facilitate_id: params[:facilitate_id])
  end

  def create
    @facilitate_provider = @provider.facilitate_providers.build(facilitate_provider_params)

    respond_to do |format|
      if @facilitate_provider.save
        format.html { redirect_to my_facilitate_provider_url(@facilitate_provider), notice: 'Facilitate provider was successfully created.' }
        format.json { render :show, status: :created, location: @facilitate_provider }
      else
        format.html { render :new }
        format.json { render json: @facilitate_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  def show
  end

  def edit
  end

  def update
    respond_to do |format|
      if @facilitate_provider.update(facilitate_provider_params)
        format.html { redirect_to @facilitate_provider, notice: 'Facilitate provider was successfully updated.' }
        format.json { render :show, status: :ok, location: @facilitate_provider }
      else
        format.html { render :edit }
        format.json { render json: @facilitate_provider.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @facilitate_provider.destroy
    respond_to do |format|
      format.html { redirect_to facilitate_providers_url, notice: 'Facilitate provider was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
  def set_provider
    @provider = current_user.provider
  end

  def set_facilitate_provider
    @facilitate_provider = FacilitateProvider.find(params[:id])
  end

  def facilitate_provider_params
    params.fetch(:facilitate_provider, {}).permit(:facilitate_id, :export_price)
  end

  def pipeline_params
    params.fetch(:pipeline, {}).permit(:name, :description)
  end

end
