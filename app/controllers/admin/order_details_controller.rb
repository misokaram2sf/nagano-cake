class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
      @order_detail = OrderDetail.find(params[:order_detail_id])
      @order = @order_detail.order
      @order_details = @order.order_details
      @order_detail.update(order_detail_params)
  end


  private

  def order_detail_params
    params.require(:order_detail).permit(:make_status)
  end

end
