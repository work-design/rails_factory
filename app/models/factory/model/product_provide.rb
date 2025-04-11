# frozen_string_literal: true

module Factory
  module Model::ProductProvide
    extend ActiveSupport::Concern

    included do
      attribute :default, :boolean

      belongs_to :provide
      belongs_to :product

      has_many :production_provides, as: :provide_config
    end

    def automatic_production_provide
      missing_provides = productions.where.missing(:production_provides).map do |i|
        { production_id: i.id, product_id: i.product_id, taxon_id: i.taxon_id, provide_id: provide_id }
      end

      production_provides.insert_all(missing_provides)
    end

    def automatic_as_default
      product.production_provides.where(provide_config_type: self.class.name).update_all(provide_id: provide_id, provide_config_id: self.id)
    end

  end
end
