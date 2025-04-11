# frozen_string_literal: true

module Factory
  module Model::TaxonProvide
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean

      belongs_to :provide
      belongs_to :taxon
    end


    def automatic_production_provide
      missing_provides = productions.where.missing(:production_provides).map do |i|
        { production_id: i.id, product_id: i.product_id, provide_id: provide_id, source_type: 'ProductProvide', source_id: self.id }
      end

      taxon.production_provides.insert_all(missing_provides)
    end


  end
end
