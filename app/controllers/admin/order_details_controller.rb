class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:id])
    @order = @order_detail.order
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)
    @order.order_details.each do |order_detail|
     if @order_detail.make_status == "in_production"
        @order.update(status:2)
        break
     end
   end

    if @order.order_details.where( make_status: 3 ).count == @order.order_details.count
       @order.update(status:3)
    end

    redirect_to request.referer
  end


  private

  def order_detail_params
    params.require(:order_detail).permit(:make_status)
  end

end
