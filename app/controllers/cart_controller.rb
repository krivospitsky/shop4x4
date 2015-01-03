class CartController < ApplicationController

  def show
    @order=Order.new(cart: @current_cart, state: :Новый)
  end
end
