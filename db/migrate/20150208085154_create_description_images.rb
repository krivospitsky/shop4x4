class CreateDescriptionImages < ActiveRecord::Migration
  def change
    create_table :description_images do |t|
      t.string :original_url
      t.string :image

      t.timestamps null: false
    end
  end
end
