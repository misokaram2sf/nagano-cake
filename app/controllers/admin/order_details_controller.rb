class Admin::OrderDetailsController < ApplicationController
  before_action :authenticate_admin!

  def update
    @order_detail = OrderDetail.find(params[:order_detail_id])
    @order = @order_detail.order
    @order_details = @order.order_details
    @order_detail.update(order_detail_params)

    if @order_detail.any? { |order_detail| order_detrail.make_status == "in_production" }
      @order.update(status: "in_production")
    end

    if @order_detail.all? { |order_detail| order_detail.make_status == "production_complete" }
      @order.update(status: "preparing_delivery")
    end

    redirect_to request.referer
  end


  private

  def order_detail_params
    params.require(:order_detail).permit(:make_status)
  end

end
