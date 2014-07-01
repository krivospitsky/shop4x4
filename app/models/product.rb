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
    :join_table => "products_linked_products")

  def self.search(search)
    if search
      find(:all, :conditions => ['lower(name) LIKE ?', "%#{search.downcase}%"])
    else
      find(:all)
    end
  end

  def availability
	  return 'В наличии' if count>0
	  return 'Под заказ' if count==0
	end
end
