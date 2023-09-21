class Public::CartItemsController < ApplicationController
    before_action :authenticate_customer!
    before_action :set_cart_item, only: [:update, :destroy]
    
    def index
        @cart_items = current_customer.cart_item
    end
    
    def create
    end
    
    def 
    end
    
    def 
    end
    
    def 
    end    
    
end
