#coding:utf-8
class Product < ActiveRecord::Base
	has_many :images, :dependent => :destroy
  include  Seoable

  accepts_nested_attributes_for :images, allow_destroy:true

  has_and_belongs_to_many(:categories,
    :join_table => "categories_products")

  has_and_belongs_to_many(:linked_categories,
    class_name: 'Category',
    :join_table => "products_linked_categories")

  has_and_belongs_to_many(:linked_products,
    class_name: 'Product',
    :join_table => "products_linked_products",
    :association_foreign_key=> 'linked_product_id' )

  def self.search(search)
    where('lower(name) LIKE :search', search: search.downcase)
  end

  def availability
	  return 'В наличии' if count>0
	  return 'Под заказ' if count==0
	end

  def linked
    result=[]
    linked_products.each do |prod|
      result << prod
    end

    linked_categories.each do |cat|
      cat.products.each do |prod|
        result << prod
      end
    end

    categories.each do |cat|
      cat.linked_products.each do |prod|
        result << prod
      end

      cat.linked_categories.each do |cat|
        cat.products.each do |prod|
          result << prod
        end
      end
    end
    result.uniq[0..7]
  end

end
