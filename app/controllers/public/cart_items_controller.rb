class Public::CartItemsController < ApplicationController
    before_action :authenticate_customer!
    #before_action :set_cart_item, only: [:update, :destroy, :destroy_all]
    
    #カートアイテムインデックスページ
    def index
        @cart_items = current_customer.cart_items
    end
    
    #カート内にアイテムを追加したとき
    def create
    #カートアイテムの箱を新しく作成    
        cart_item = CartItem.new(cart_item_params)
    #カートの持ち主が誰かを記載    
        cart_item.customer_id = current_customer.id
    #カートの中のアイテムは外部キーのアイテムidと同じ
    #(カート内のアイテムはアイテムから引用してきていますって感じ？)
        cart_item.item_id = cart_item_params[:item_id]
     
     #カートアイテムに追加された商品は既に入ってるものと同じか？   
        if CartItem.find_by(item_id: params[:cart_item][:item_id]).present?
     #同じとき↓
            cart_item = CartItem.find_by(item_id: params[:cart_item][:item_id])
     #元々入っていた商品の個数にparams[以下省略]の値を数字型にして加える
            cart_item.amount += params[:cart_item][:amount].to_i
     #カートアイテムを更新、リダイレクト 
            cart_item.update(amount: cart_item.amount)
            redirect_to cart_items_path
        else
     #カートアイテムを保存、リダイレクト
            cart_item.save
            redirect_to cart_items_path
        end    
    end
    
    #数量を変更するアクション
    def update
        cart_item = CartItem.find(params[:id])
        cart_item.update(cart_item_params)
        redirect_back(fallback_location: root_path)
    end
    
    def destroy
        cart_item = CartItem.find(params[:id])
        cart_item.destroy
        redirect_to cart_item_path
    end    
    
    #カート内アイテム全消去
    def destroy_all
        CartItem.destroy_all
        redirect_back(fallback_location: cart_items_path)
    end    
    
    private
    
    def cart_item_params
        params.require(:cart_item).permit(:item_id, :amount)
    end
    
    
end
