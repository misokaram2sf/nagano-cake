class Public::CustomersController < ApplicationController
  
  def customer_params
  params.require(:customer).permit(:last_name, :first_name, :last_name_kana, :first_name_kana,
                   :postal_code, :address, :phone_number, :email)
  end
end