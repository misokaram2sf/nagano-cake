class Public::HomesController < ApplicationController
    
    def top
        @new_items = Item.where(is_active: true).last(3)
        @genres = Genre.all
    end    
    
end
