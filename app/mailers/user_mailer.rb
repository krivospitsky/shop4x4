#coding:utf-8
class UserMailer < ActionMailer::Base
	helper :application

  def order_confirmation(order)
    @order=order
    mail(to:order.email, subject:"Подтверждение заказа", from:Settings.owner_email)
  end
  def new_order(order)
    @order=order
    if order.email
    	mail(to:Settings.owner_email, subject:"Новый заказ", from:order.email)
    else
    	mail(to:Settings.owner_email, subject:"Новый заказ", from:Settings.owner_email)
    end
  end
end
