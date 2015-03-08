class AddAvailabilityToVariants < ActiveRecord::Migration
  def change
    add_column :variants, :availability, :string
  end
end
