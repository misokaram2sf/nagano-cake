class Public::HomesController < ApplicationController
    
    def top
        @new_items = Item.where(is_active: true).last(4)
        @genres = Genre.all
    end    
    
end
