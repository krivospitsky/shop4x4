class Cart < ActiveRecord::Base
  has_many :cart_items, dependent: :destroy
  belongs_to :user

  def self.get(cart_id = nil, user_id = nil)
    cart = find_by_user_id(user_id) if user_id
    cart.concatinate(cart_id) if cart
    cart ||= find_by_id(cart_id)
    cart ||= create(user_id: user_id)
    cart.user_id ||= user_id
    cart.save
    cart
  end

  def get_item(product_id, variant_id)
    items.find_or_initialize_by(product_id: product_id,
                                variant_id: variant_id)
  end

  def add(product_id, variant_id, count)
    item = get_item(product_id, variant_id)
    item.incrase(count)
    item
  end

  def concatinate(cart_id)
    return if id == cart_id
    cart = Cart.find(cart_id)
    cart.items.each do |item|
      item.move_to(id)
    end
    cart.reload.destroy
  end
end
