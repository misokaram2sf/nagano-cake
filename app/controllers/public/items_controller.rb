class Public::ItemsController < ApplicationController


  def index
    @items = Item.page(params[:page]).per(12)
    @item_amount = Item.all
  end

  def show
    @item = Item.find(params[:id])
    @cart_item = CartItem
  end






end
