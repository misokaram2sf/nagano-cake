class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def index
    @order = current_customer.orders
  end

  def show
    @order = Order.find(params[:id])
    @order_detail = @order.order_detail
  end

  def new
    @order = Order.new
  end

  def confirm
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
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(params[:id])
    if @order.save
      cart_items.each do |cart|
        order_detail = OrderDetail.new
        order_detail.item_id = cart.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart.amount
        order_detail.unit_price = cart.item.price
        order_detail..save
      end
      redirect_to public_orders_complete_path
      cart_item.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end


  private

  def order_params
    params.require(:order).permit(:total_amount, :status, :postal_code, :address, :name, :postage, :payment_method)
  end

end
