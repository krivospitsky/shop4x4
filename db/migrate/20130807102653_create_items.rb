class CreateItems < ActiveRecord::Migration
  def change
    create_table :items do |t|
      t.integer :product_id
      t.integer :cart_id
      t.integer :order_id
      t.integer :quantity
      t.decimal :price
      t.integer :variable_id

      t.timestamps
    end

    add_index :items, :product_id
    add_index :items, :cart_id
    add_index :items, :order_id
    add_index :items, :variable_id

  end
end
