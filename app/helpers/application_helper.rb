module ApplicationHelper
  def product_path(product, category=nil)
  	category ||= product.categories.first 
  	original_product_path(category.path, product)
  end
end
