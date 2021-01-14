module Factory
  class Admin::PartProvidersController < Admin::BaseController
    before_action :set_part
    before_action :set_part_provider, only: [:show, :edit, :update, :destroy]

    def index
      q_params = {}
      q_params.merge! params.permit(:good_type, :good_id)

      @part_providers = @part.part_providers.default_where(q_params).order(id: :asc).page(params[:page])
    end

    def new
      @part_provider = @part.part_providers.build
    end

    def create
      @part_provider = @part.part_providers.build(part_provider_params)

      unless @part_provider.save
        render :new, locals: { model: @part_provider }, status: :unprocessable_entity
      end
    end

    def show
    end

    def edit
    end

    def update
      @part_provider.assign_attributes(part_provider_params)

      unless @part_provider.save
        render :edit, locals: { model: @part_provider }, status: :unprocessable_entity
      end
    end

    def destroy
      @part_provider.destroy
    end

    private
    def set_part
      @part = Part.find params[:part_id]
    end

    def set_part_provider
      @part_provider = @part.part_providers.find(params[:id])
    end

    def part_provider_params
      params.fetch(:part_provider, {}).permit(
        :verified,
        :selected
      )
    end

  end
end
