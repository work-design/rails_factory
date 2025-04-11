# frozen_string_literal: true

module Factory
  module Model::ProductProvide
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean

      belongs_to :provide
      belongs_to :product
    end

    def automatic_production_provide
      missing_provides = productions.where.missing(:production_provides).map do |i|
        { production_id: i.id, provide_id: provide_id, source_type: 'ProductProvide', source_id: self.id }
      end

      product.production_provides.insert_all(missing_provides)
    end


  end
end
