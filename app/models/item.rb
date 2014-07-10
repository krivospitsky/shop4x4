class Item < ActiveRecord::Base
  belongs_to :cart
  belongs_to :order
	belongs_to :product
  # belongs_to :variable

  def change(count = 1)
    self.quantity = 0 if new_record?
    self.quantity += count
    save
  end

  def move_to(_cart_id)
    return destroy if Item.where(product_id: product_id, variable_id: variable_id, cart_id: _cart_id).any?
    update_attributes(cart_id: _cart_id)
  end

end
