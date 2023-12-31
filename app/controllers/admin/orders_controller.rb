class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def index
    orders = Order.order("created_at desc")
    @orders = Kaminari.paginate_array(orders).page(params[:page]).per(10)
  end

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total_item_amount = @order_details.sum { |order_detail| order_detail.subtotal }
  end

  def update
    @order = Order.find(params[:id])
    @order_details = OrderDetail.where(order_id: params[:id])
    if @order.update(order_params)
       @order_details.update_all(make_status: 1) if @order.status == "payment_confirmation"
    end
    redirect_to admin_order_path(@order)
  end

  private

  def order_params
    params.require(:order).permit(:status)
  end

end
