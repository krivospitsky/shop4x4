class CartController < ApplicationController

  # GET /carts
  # GET /carts.json
  def index
    @order=Order.new(cart: @current_cart)
    render 'show'
  end

  def show
    @order=Order.new(cart: @current_cart)
  end
end
