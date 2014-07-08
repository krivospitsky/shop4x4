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

    result += linked_products.all

    linked_categories.each do |cat|
      result += cat.products.all
    end

    categories.each do |cat|
      result += cat.linked_products.all

      cat.linked_categories.each do |cat|
        result += cat.products.all
      end
    end
    result.uniq[0..7]
  end

  def discount_price
    max_discount1 = Promotion.current.joins(:products).where('products.id = ?', id).maximum(:discount) || 0
    max_discount2 = Promotion.current.joins(:categories).where('categories.id in (?)', categories.pluck(:id)).maximum(:discount) || 0
    max_discount = max_discount1 > max_discount2 ? max_discount1 : max_discount2
    return price * (100 - max_discount) / 100 if max_discount
    false
  end
end
