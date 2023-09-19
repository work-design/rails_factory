module Factory
  class Admin::StockLogsController < Admin::BaseController
    before_action :set_production
    before_action :set_stock_log, only: [:show, :edit, :update, :destroy]
    before_action :set_new_stock_log, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! params.permit('start_at-gte', 'start_at-lte', 'produce_on-gte', 'produce_on-lte')

      @stock_logs = @production.stock_logs.default_where(q_params).order(id: :desc).page(params[:page])
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_stock_log
      @stock_log = @production.stock_logs.find(params[:id])
    end

    def set_new_stock_log
      @stock_log = @production.stock_logs.build(stock_log_params)
    end

    def stock_log_params
      params.fetch(:stock_log, {}).permit(
        :note
      )
    end

  end
end
