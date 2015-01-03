class OrdersController < ApplicationController
  def show
    @order = Order.find_by  secure_key: params[:id]
  end

  def create
    @order = Order.new(order_params)

    if @order.save
      UserMailer.new_order(@order).deliver
      UserMailer.order_confirmation(@order).deliver
      session[:cart_id]=nil
      respond_with @order, location: "/orders/#{@order.secure_key}"
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def order_params
      params.require(:order).permit(:cart_id, :state, :name, :city, :phone, :email, :zip, :address, :comment)
    end
end
