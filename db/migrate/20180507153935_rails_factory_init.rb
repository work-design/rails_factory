class RailsFactoryInit < ActiveRecord::Migration[5.2]
  def change

    create_table :products do |t|
      t.string :name
      t.string :qr_prefix
      t.timestamps
    end

    create_table :parts do |t|
      t.references :provider
      t.string :name
      t.string :qr_prefix
      t.timestamps
    end

    create_table :part_taxons do |t|
      t.string :name
      t.integer :position, default: 1
      t.references :parent
      t.timestamps
    end

    create_table :product_parts do |t|
      t.references :product
      t.references :part
      t.timestamps
    end

    create_table :product_items do |t|
      t.references :product
      t.string :qr_code
      t.string :state
      t.datetime :produced_at
      t.timestamps
    end

    create_table :part_items do |t|
      t.references :part
      t.references :product_item
      t.string :qr_code
      t.string :state
      t.datetime :received_at
      t.timestamps
    end

    create_table :part_plans do |t|
      t.references :part
      t.datetime :start_at
      t.datetime :finish_at
      t.string :state
      t.integer :purchased_count, default: 0
      t.integer :received_count, default: 0
      t.timestamps
    end

    create_table :product_plans do |t|
      t.references :product
      t.datetime :start_at
      t.datetime :finish_at
      t.string :state
      t.integer :planned_count, default: 0
      t.integer :produced_count, default: 0
      t.timestamps
    end

  end
end
