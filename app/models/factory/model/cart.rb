module Factory
  module Model::Cart
    extend ActiveSupport::Concern

    included do
      has_many :production_carts, ->{ order(customized_at: :desc) }, class_name: 'Factory::ProductionCart', dependent: :destroy
      has_many :productions, through: :production_carts
    end

  end
end
