class DescriptionImage < ActiveRecord::Base
	mount_uploader :image, ImageUploader
end
