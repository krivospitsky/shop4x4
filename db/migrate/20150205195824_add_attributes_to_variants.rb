class AddAttributesToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :attr, :string
  end
end
