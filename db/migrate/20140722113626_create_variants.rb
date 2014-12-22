class CreateVariants < ActiveRecord::Migration
  def change
    create_table :variants do |t|
      t.integer :product_id
      t.string :name
      t.string :sku
      t.integer :price
      t.integer :count
      t.boolean :enabled

      t.timestamps
    end
  end
end
