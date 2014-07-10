module CurrentCart
  include ActiveSupport::Concern

  def self.included(c)
    c.helper_method :cart
  end

  def cart
    @cart ||= set_cart
  end

  def set_cart
    cart = Cart.get(session[:cart_id], current_user.try(:id))
    session[:cart_id] = cart.id
    cart
  end
end
