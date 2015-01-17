module ApplicationHelper
  def product_path(product, category=nil)
  	if Settings.disable_categories
		original_product_path('', product)
  	else
	  	category ||= product.categories.first 
	  	original_product_path(category.path, product)
	end
  end

  def catalog_path
	root_path
  end


 #  def page_path(page)
 #  	if page == Page.first
	# 	root_path
 #  	else
	# 	original_page_path(page)
	# end
 #  end
end
