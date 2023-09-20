class Admin::HomesController < ApplicationController
   
  def top
    @order = Order.all
  end
  
  def about
    
  end
end
