class CreateSeo < ActiveRecord::Migration
  def change
    create_table :seo do |t|
      t.references :seoable, :polymorphic => true
      t.string :title
      t.text :keywords
      t.text :description

      t.timestamps
    end
  end
end
