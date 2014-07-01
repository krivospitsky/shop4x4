class Page < ActiveRecord::Base
  POSITIONS=[ "menu", "footer", "menu_and_footer"]
  scope :in_menu, -> { where('(position="menu" or position="menu_and_footer")') }
  scope :in_footer, -> { where('(position="footer" or position="menu_and_footer")') }
  mount_uploader :image, ImageUploader

  include  Seoable

end
