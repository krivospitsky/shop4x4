class Cart < ActiveRecord::Base
	has_many :cart_items
  has_one :order
end
