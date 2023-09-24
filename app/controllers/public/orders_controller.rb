class Public::OrdersController < ApplicationController
  before_action :authenticate_customer!


  def index
    @orders = current_customer.orders.order("created_at desc")
    @genres = Genre.all
  end

  def show
     @order = current_customer.orders.find(params[:id])
     @order_details = @order.order_details
     @total_item_amount = @order_details.sum { |order_detail| order_detail.subtotal }
  end

  def new
    @order = Order.new
  end

  def confirm
    @order = Order.new(order_params)
    if params[:order][:address_id] == "0"
      @order.postal_code = current_customer.postal_code
      @order.address = current_customer.address
      @order.name = current_customer.last_name + current_customer.first_name
    elsif params[:order][:address_id] == "1"
      @order.postal_code = Address.find(params[:order][:address_id]).postal_code
      @order.address = Address.find(params[:order][:address_id]).address
      @order.name = Address.find(params[:order][:address_id]).name
    elsif params[:order][:address_id] == "2"
      @order.postal_code = params[:order][:postal_code]
      @order.address = params[:order][:address]
      @order.name = params[:order][:name]
    end

    if @order.postal_code.blank? || @order.address.blank? || @order.name.blank?
      flash.now[:notice] = "正しい住所を入力してください。"
      render :new
    end
    @cart_items = current_customer.cart_items
    @order.postage = 800
    @total = @cart_items.inject(0) { |sum, item| sum + item.subtotal }
    @total_pay = @total + @order.postage
  end

  def complete
  end

  def create
    cart_items = current_customer.cart_items.all
    @order = current_customer.orders.new(order_params)
    if @order.save
      cart_items.each do |cart_item|
        order_detail = OrderDetail.new
        order_detail.item_id = cart_item.item_id
        order_detail.order_id = @order.id
        order_detail.amount = cart_item.amount
        order_detail.unit_price = cart_item.item.price * 1.1
        order_detail.save
      end
      redirect_to orders_complete_path
      cart_items.destroy_all
    else
      @order = Order.new(order_params)
      render :new
    end
  end


  private

  def order_params
    params.require(:order).permit(:total_amount, :status, :postal_code, :address, :name, :postage, :payment_method)
  end

  def address_params
    params.require(:order).permit(:postal_code, :address, :name)
  end
end
