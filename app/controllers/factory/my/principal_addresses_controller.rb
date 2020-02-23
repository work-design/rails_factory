class Factory::My::PrincipalAddressesController < Factory::My::BaseController
  before_action :set_principal_address, only: [:show]

  def index
    @addresses = current_user.principal_addresses.page(params[:page])
  end

  def show
    @customs = @address.customs
  end

  def dates
    @dates = x
  end

  private
  def set_principal_address
    @address = current_user.principal_addresses.find(params[:id])
  end

end
