class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.text :description
      t.integer :sort_order
	  t.integer :price
	  t.string :sku
	  t.integer :count
	  t.boolean :enabled
      t.timestamps
    end
  end
end
