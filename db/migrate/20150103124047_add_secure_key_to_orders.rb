class AddSecureKeyToOrders < ActiveRecord::Migration
	def change
    	add_column :orders, :secure_key, :string
  	end  
end
