class Public::OrdersController < ApplicationController
  bofore_action :authenticate_customer!
  
  def index
  end

  def show
  end

  def new
  end

  def comfirm
    @order = Order.new
    @cart_items = CartItem.all
    @item = Item.find(params[:id])
  end

  def complete
  end

  def create
  end


  private

  def porder_params
    params.require(:order).permit(:total_amount, :status, :postalcode, :address, :name, :postage, :payment_method)
  end
  
end
