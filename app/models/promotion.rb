class Promotion < ActiveRecord::Base
  include  Seoable
  has_and_belongs_to_many(:categories)
  has_and_belongs_to_many(:products)
  mount_uploader :banner
end
