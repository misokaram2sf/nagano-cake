class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!

  
  def index
  end

  def show
  end

  def new
  end

  def comfirm
    @order = Order.new(order_params)
    @address = Address.find(params[:order][:address_id])
    @order.postal_code = @address.postal_code
    @order.address = @address.address
    @order.name = @address.name
    @cart_items = CartItem.all
  end

  def complete
  end

  def create
  end


  private

  def porder_params
    params.require(:order).permit(:total_amount, :status, :postal_code, :address, :name, :postage, :payment_method)
  end
  
end
