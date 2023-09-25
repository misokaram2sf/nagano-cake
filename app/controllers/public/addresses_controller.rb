class Public::AddressesController < ApplicationController
    before_action :authenticate_customer!
    
    def index
        @addresses = current_customer.addresses.all
        @address = Address.new
    end
    
    def edit
        @address = Address.find(params[:id])
    end    
    
    def create
        @address = Address.new(address_params)
        @address.customer_id = current_customer.id
        @address.save
        redirect_to addresses_path
    end
    
    def update
        @address = Address.find(params[:id])
        @address.update(address_params)
        redirect_to addresses_path
    end    
    
    def destroy
        Address.find(params[:id]).destroy
        redirect_to addresses_path
    end    
    
    private
    
    def address_params
        params.require(:address).permit(:customer_id, :postal_code, :address, :name, :customer_id)
    end    
end
