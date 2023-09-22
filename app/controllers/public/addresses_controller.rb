class Public::AddressesController < ApplicationController
    
    def index
        @address = Address.new
        @address.save
        @addresses = Address.all
    end    
    
    def create
        #@address_new = Address.new#(address_params)
    end 
    
    private
    
    def address_params
        params.require(:address).permit(:postal_code, :address, :name, :customer_id)
    end    
end
