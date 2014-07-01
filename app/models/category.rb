class Category < ActiveRecord::Base
	has_many :products
	has_many :children, :class_name => "Category",
    	:foreign_key => "parent_id"
	belongs_to :parent, :class_name => "Category"

  has_and_belongs_to_many(:products,
    :join_table => "categories_products")

  has_and_belongs_to_many(:linked_products,
    :join_table => "categories_linked_products")

  has_and_belongs_to_many(:linked_categories,
    :join_table => "categories_linked_categories")

  mount_uploader :image, ImageUploader

  attr_accessor :delete_image
  before_validation { self.image.clear if self.delete_image == '1' }
end
