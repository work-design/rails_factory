class Factory::Admin::FacilitateProvidersController < Factory::Admin::BaseController
  before_action :set_facilitate, only: [:index]
  before_action :set_facilitate_provider, only: [:show, :edit, :verify, :select, :update, :destroy]

  def index
    @facilitate_providers = @facilitate.facilitate_providers.order(id: :asc).page(params[:page])
  end

  def show
  end

  def new
    @facilitate_provider = @facilitate.facilitate_providers.build
  end

  def edit
  end

  def verify
    if params[:verified] == '1'
      @facilitate_provider.update(verified: true)
    else
      @facilitate_provider.update(verified: false)
    end
  end

  def select
    @facilitate_provider.set_selected
    redirect_to admin_facilitate_facilitate_providers_url(@facilitate_provider.facilitate_id)
  end

  def create
    @facilitate_provider = @facilitate.facilitate_providers.build(facilitate_provider_params)

    respond_to do |format|
      if @facilitate_provider.save
        format.html { redirect_to @facilitate_provider, notice: 'Facilitate provider was successfully created.' }
        format.json { render :show, status: :created, location: @facilitate_provider }
      else
        format.html { render :new }
        format.json { render json: @facilitate_provider.errors, status: :unprocessable_entity }
      end
    end
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
  def set_facilitate
    @facilitate = Facilitate.find params[:facilitate_id]
  end

  def set_facilitate_provider
    @facilitate_provider = FacilitateProvider.find(params[:id])
  end

  def facilitate_provider_params
    params.fetch(:facilitate_provider, {})
  end
end
