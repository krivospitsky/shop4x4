class ProductsController < ApplicationController
  responders :flash, :http_cache

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
    @linked=@product.linked
    @cart_item = @current_cart.cart_items.new(product_id: @product.id, quantity:1)

    @breadcrumbs=[]
    @breadcrumbs << @product
    if params[:category_path]
      
      tmp=Category.find(params[:category_path].split('/').last)
      while tmp do 
        @breadcrumbs << tmp
        tmp=tmp.parent
      end
      @breadcrumbs=@breadcrumbs.reverse
    end

  end

  def index
    if params[:category_id]
      @category = Category.find(params[:category_id])
      @products=@category.products.enabled
      @title = @category.name

      @breadcrumbs=[]
      tmp=@category
      while tmp do 
        @breadcrumbs << tmp
        tmp=tmp.parent
      end
      @breadcrumbs=@breadcrumbs.reverse

    else
      @products=Product.enabled
    end
  end
end
