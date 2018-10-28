class RailsFactoryInit < ActiveRecord::Migration[5.2]
  def change

    create_table :products do |t|
      t.string :name
      t.string :qr_prefix
      t.timestamps
    end

    create_table :parts do |t|
      t.references :provider
      t.references :part_taxon
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

    create_table :part_taxon_hierarchies, id: false do |t|
      t.integer :ancestor_id, null: false
      t.integer :descendant_id, null: false
      t.integer :generations, null: false
    end
    add_index :part_taxon_hierarchies, [:ancestor_id, :descendant_id, :generations], unique: true, name: 'part_taxon_anc_desc_idx'
    add_index :part_taxon_hierarchies, [:descendant_id], name: 'part_taxon_desc_idx'

    create_table :product_parts do |t|
      t.references :product
      t.references :part
      t.timestamps
    end

    create_table :customs do |t|
      t.string :name
      t.references :customer, polymorphic: true
      t.string :state
      t.string :qr_code
      t.datetime :ordered_at
      t.timestamps
    end

    create_table :custom_parts do |t|
      t.references :custom
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
