class CartItem < ActiveRecord::Base
  belongs_to :cart
  belongs_to :order, foreign_key: :cart_id, primary_key: :cart_id
	belongs_to :product
end
