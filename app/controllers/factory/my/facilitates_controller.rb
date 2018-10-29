class Waiting::My::FacilitatesController < Waiting::My::BaseController
  before_action :set_facilitate, only: [:order]

  def order
    @facilitate.generate_order(current_user)
    redirect_to my_orders_url
  end

  private
  def set_facilitate
    @facilitate = Facilitate.find(params[:id])
  end

  def facilitate_params
    params.fetch(:facilitate, {})
  end
end
