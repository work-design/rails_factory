module Factory
  class ProductSyncPositionJob < ApplicationJob

    def perform(product)
      product.sync_position
    end

  end
end
