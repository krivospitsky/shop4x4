class CreateCategories < ActiveRecord::Migration
  def change
    create_table :categories do |t|
      t.string :name
      t.text :description
      t.integer :parent_id
      t.string :image
      t.boolean :enabled
      t.integer :sort_order

      t.timestamps
    end
  end
end
