module Factory
  class ProductMinMaxPriceJob < ApplicationJob

    def perform(product)
      product.compute_min_max!
    end

  end
end
