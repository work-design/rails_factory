class CreateProductItems < ActiveRecord::Migration[5.2]
  def change
    create_table :product_items do |t|
      t.references :product
      t.string :qr_code
      t.string :state
      t.datetime :produced_at
      t.timestamps
    end

    create_table :part_items do |t|
      t.references :part
      t.string :qr_code
      t.string :state
      t.datetime :received_at
      t.timestamps
    end

  end
end
