# This migration comes from the_trade_engine (originally 20171115063702)
class CreatePromoteBuyers < ActiveRecord::Migration[5.1]
  def change
    
    create_table :promote_buyers do |t|
      t.references :buyer
      t.references :promote
      t.timestamps
    end

    create_table :promote_goods do |t|
      t.references :good, polymorphic: true
      t.references :promote
      t.timestamps
    end

    create_table :serve_goods do |t|
      t.references :good, polymorphic: true
      t.references :serve
      t.timestamps
    end

    create_table :cart_item_serves do |t|
      t.references :cart_item
      t.references :serve
      t.string :scope
      t.decimal :price, precision: 10, scale: 2
      t.timestamps
    end
    
  end
end
