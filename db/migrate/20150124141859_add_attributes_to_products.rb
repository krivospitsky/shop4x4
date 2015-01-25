class AddAttributesToProducts < ActiveRecord::Migration
  def change
    add_column :products, :attr, :string
  end
end
