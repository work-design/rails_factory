class CreateAdminProducts < ActiveRecord::Migration[5.2]
  def change
    create_table :products do |t|
      t.string :name
      t.string :qr_code
      t.timestamps
    end

    create_table :parts do |t|
      t.references :provider
      t.string :name
      t.string :qr_code
      t.timestamps
    end

    create_table :product_parts do |t|
      t.references :product
      t.references :part
      t.timestamps
    end

  end
end
