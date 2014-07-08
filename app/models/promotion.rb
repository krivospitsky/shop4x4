class Promotion < ActiveRecord::Base
  include  Seoable
  has_and_belongs_to_many(:categories)

  has_and_belongs_to_many(:products)
  mount_uploader :banner

	scope :enabled, -> { where(enabled: 't') }
  scope :current, -> { enabled.where('start_at< ? or end_at> ?', Time.now, Time.now) }

end
