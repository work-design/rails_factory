class AddProductItemToPartItem < ActiveRecord::Migration[5.2]
  def change
    add_reference :part_items, :product_item
  end
end
