class CreateOrders < ActiveRecord::Migration
  def change
    create_table :orders do |t|
      t.integer :cart_id
      t.string :state
      t.string :name
      t.string :email
      t.string :phone
      t.string :zip
      t.string :city
      t.string :address
      t.string :comment

      t.timestamps
    end
  end
end
