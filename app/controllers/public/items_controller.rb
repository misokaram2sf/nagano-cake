class Public::ItemsController < ApplicationController
   before_action :authenticate_admin!

  
  def index 
    @items = Item.all.page(params[:page])
     @item = Item.new
     @items = Item.all
     @images = Item.all
  end
  
  def new
    @item = Item.new
  end

  def create
     @item = Item.new(item_params)

    if @item.save
    redirect_to admin_item_path(@item.id), notice: "Item was successfully created."
    else
      @items = Item.all
      @admin = current_admin
      render:new
    end
  end

  def show
    @item = Item.find(params[:id])
    @item =Item.new
    # @image = Image.find(params[:id])
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:notice] ="Item was successfully updated"
      redirect_to admin_item_path(@item)
    else
      render "show"
    end
  end

  private
  # def if_not_admin
  #   redirect_to root_path unless current_user.admin?
  # end
  def item_params
    params.require(:item).permit(:image,:name,:introduction,:genre_id,:price,:is_active)
  end
    
end
