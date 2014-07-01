class CreateProductsAndCategoriesLinks < ActiveRecord::Migration
  def change
    create_table :categories_products do |t|
      t.integer :category_id
      t.integer :product_id
    end
    create_table :categories_linked_products do |t|
      t.integer :category_id
      t.integer :product_id
    end
    create_table :categories_linked_categories do |t|
      t.integer :category_id
      t.integer :category_id
    end
    create_table :products_linked_products do |t|
      t.integer :product_id
      t.integer :product_id
    end
    create_table :products_linked_categories do |t|
      t.integer :product_id
      t.integer :category_id
    end
  end
end
