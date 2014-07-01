class CreateProducts < ActiveRecord::Migration
  def change
    create_table :products do |t|
      t.string :name
      t.string :options
      t.text :description
      t.integer :price
      t.string :sku
      t.integer :count
      t.boolean :enabled
      t.integer :sort_order

      t.timestamps
    end
  end
end
