class CreatePromotions < ActiveRecord::Migration
  def change
    create_table :promotions do |t|
      t.string :name
      t.text :description
      t.integer :sort_order
      t.boolean :enabled
      t.boolean :has_banner
      t.string :banner
      t.boolean :send_mail
      t.date :start_at
      t.date :end_at
      t.integer :discount

      t.timestamps
    end
    create_table :products_promotions do |t|
      t.integer :promotion_id
      t.integer :product_id
    end
    create_table :categories_promotions do |t|
      t.integer :promotion_id
      t.integer :category_id
    end
  end
end
