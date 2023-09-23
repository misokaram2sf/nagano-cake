class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def index
    @orders = current_customer.orders.order("created_at desc")
    @genres = Genre.all
  end

  def show
     @order = current_customer.orders.find(params[:id])
  end

  def new
    @order = Order.new
  end

  def confirm
    @order = current_customer.orders.new(order_params)
    @order.postal_code = current_customer.postal_code
    @order.address = current_customer.address
    @order.name = current_customer.last_name + current_customer.first_name
    @order.postage = 800
    
    @cart_items = current_customer.cart_items

  end

  def complete
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(params[:id])
    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.unit_price = cart_item.item.price * 1.1
        order_detail.save
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
