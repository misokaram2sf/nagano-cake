class Admin::OrdersController < ApplicationController
  before_action :authenticate_admin!

  def show
    @order = Order.find(params[:id])
    @order_details = @order.order_details
    @total_item_amount = @order_details.sum { |order_detail| order_detail.subtotal }
  end



end
