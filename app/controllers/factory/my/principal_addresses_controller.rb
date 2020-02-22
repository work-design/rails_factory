class Factory::My::PrincipalAddressesController < Factory::My::BaseController
  before_action :set_principal_address, only: [:show, :edit, :update, :destroy]

  def index
    @principal_addresses = current_user.principal_addresses.page(params[:page])
  end

  def show
  end

  def edit
  end

  def update
    @principal_address.assign_attributes(principal_address_params)

    unless @principal_address.save
      render :edit, locals: { model: @principal_address }, status: :unprocessable_entity
    end
  end

  def destroy
    @principal_address.destroy
  end

  private
  def set_principal_address
    @principal_address = PrincipalAddress.find(params[:id])
  end

  def principal_address_params
    params.fetch(:principal_address, {}).permit(
    )
  end

end
