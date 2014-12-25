module ApplicationHelper
  def product_path(product, category=nil)
  	if Settings.disable_categories
		original_product_path('', product)
  	else
	  	category ||= product.categories.first 
	  	original_product_path(category.path, product)
	end
  end
end
