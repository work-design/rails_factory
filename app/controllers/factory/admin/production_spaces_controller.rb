module Factory
  class Admin::ProductionSpacesController < Admin::BaseController
    before_action :set_production
    before_action :set_production_space, only: [:show, :edit, :update, :destroy]
    before_action :set_new_production_space, only: [:new, :create, :rooms, :desks]
    before_action :set_stations, only: [:new, :create]

    def index
      q_params = {}
      q_params.merge! params.permit(:station_id, :room_id, :grid_id, :desk_id)

      @production_spaces = @production.production_spaces.default_where(q_params).order(id: :desc).page(params[:page])
    end

    def rooms
      @station = Space::Station.find production_space_params[:station_id]
    end

    def desks
      @room = Space::Room.find production_space_params[:room_id]
    end

    private
    def set_production
      @production = Production.find params[:production_id]
    end

    def set_stations
      @stations = Space::Station.default_where(default_params)
    end

    def set_production_space
      @production_space = @production.production_spaces.find(params[:id])
    end

    def set_new_production_space
      @production_space = @production.production_spaces.build(production_space_params)
    end

    def production_space_params
      params.fetch(:production_space, {}).permit(
        :station_id,
        :room_id,
        :desk_id
      )
    end

  end
end
