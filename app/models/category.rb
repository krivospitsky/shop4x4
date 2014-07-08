class Category < ActiveRecord::Base
	has_many :products
	has_many :children, :class_name => "Category",
    	:foreign_key => "parent_id"
	belongs_to :parent, :class_name => "Category"

  has_and_belongs_to_many(:products,
    class_name: 'Product',
    :join_table => "categories_products")

  has_and_belongs_to_many(:linked_products,
    class_name: 'Product',
    :join_table => "categories_linked_products")

  has_and_belongs_to_many(:linked_categories,
    class_name: 'Category',
    :join_table => "categories_linked_categories",
    :association_foreign_key=> 'linked_category_id')

  scope :enabled, -> { where(enabled: 't') }


  mount_uploader :image, ImageUploader

  include  Seoable

  attr_accessor :delete_image
  before_validation { self.image.clear if self.delete_image == '1' }

  def path
    return parent.path+"/"+id.to_s if parent
    id.to_s
  end

end
