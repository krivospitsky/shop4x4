class ProductsController < ApplicationController
  def search
    @text=params[:text]
    @products=Product.search(params[:text])
    @title="Результаты поиска"
  end

  # GET /products/1
  # GET /products/1.json
  def show
    @product = Product.find(params[:id])
    @title=@product.title
    @cart_item = @current_cart.cart_items.new(product_id: @product.id, quantity:1)
  end

  def index
  end
end
