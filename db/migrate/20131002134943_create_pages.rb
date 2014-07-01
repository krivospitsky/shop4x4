class CreatePages < ActiveRecord::Migration
  def change
    create_table :pages do |t|
      t.string :title
      t.text :text
      t.string :image
      t.boolean :enabled
      t.integer :sort_order
      t.string :position

      t.timestamps
    end
  end
end
