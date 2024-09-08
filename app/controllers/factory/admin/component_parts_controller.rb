module Factory
  class Admin::ComponentPartsController < Admin::BaseController
    before_action :set_component
    before_action :set_component_part, only: [:show, :edit, :update, :destroy, :actions]
    before_action :set_new_component_part, only: [:new, :create]

    def index
      @component_parts = @component.component_parts.order(part_id: :asc)
      @productions = @component.part_taxon.productions.where.not(id: @component_parts.pluck(:part_id)).includes(:product)
    end

    private
    def set_component
      @component = Component.find params[:component_id]
      @taxon = @component.taxon
    end

    def set_new_component_part
      @component_part = @component.component_parts.build(component_part_params)
    end

    def set_component_part
      @component_part = @component.component_parts.find(params[:id])
    end

    def component_part_params
      params.fetch(:component_part, {}).permit(
        :part_id,
        :default,
        :min,
        :max
      )
    end

  end
end
