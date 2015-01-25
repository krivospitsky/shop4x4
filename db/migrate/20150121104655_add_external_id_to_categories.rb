class AddExternalIdToCategories < ActiveRecord::Migration
  def change
    add_column :categories, :external_id, :string
  end
end
