#coding:utf-8
class Order < ActiveRecord::Base
  belongs_to :cart
  has_many :cart_items, foreign_key: :cart_id, primary_key: :cart_id
  accepts_nested_attributes_for :cart_items, allow_destroy:true

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
end
