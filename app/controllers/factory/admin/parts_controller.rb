module Factory
  class Admin::PartsController < Admin::BaseController
    before_action :set_part, only: [:show, :edit, :update, :destroy]
    before_action :set_part_taxons, only: [:index, :new, :edit]

    def index
      q_params = {}
      q_params.merge! default_params
      q_params.merge! params.permit(:name, :provider_id, :part_taxon_id)

      # todo should order by part taxon position
      @parts = Part.default_where(q_params).order(part_taxon_id: :asc).page(params[:page])
    end

    def new
      @part = Part.new
      @part.part_taxon = PartTaxon.new(organ_id: current_organ&.id)
    end

    def create
      @part = Part.new(part_params)

      unless @part.save
        render :new, locals: { model: @part }, status: :unprocessable_entity
      end
    end

    def update
      @part.assign_attributes(part_params)

      unless @part.save
        render :edit, locals: { model: @part }, status: :unprocessable_entity
      end
    end

    private
    def set_part
      @part = Part.find params[:id]
    end

    def set_part_taxons
      @part_taxons = Factory::PartTaxon.default_where(default_params).order(id: :asc)
    end

    def part_params
      p = params.fetch(:part, {}).permit(
        :name,
        :qr_prefix,
        :import_price,
        :profit_price,
        :logo,
        :part_taxon_id
      )
      p.merge! default_form_params
    end

  end
end
