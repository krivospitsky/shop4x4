#coding:utf-8
class Order < ActiveRecord::Base
  belongs_to :cart
  has_many :cart_items, foreign_key: :cart_id, primary_key: :cart_id
  accepts_nested_attributes_for :cart_items, allow_destroy:true

  # validates :name, presence: true
#  validates :email, presence: true
  validates :phone, presence: true

  state_machine :state, :initial => :Новый do
    event :processing do
      transition :Новый => :Обработка
    end
    event :processed do
      transition :Обработка => :Выполнен
    end
    event :reject do
      transition any - :Отменен => :Отменен
    end
  end

  before_save :set_secure_key
  def set_secure_key
    self.secure_key ||= SecureRandom.hex(16)
  end
end
