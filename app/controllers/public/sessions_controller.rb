# frozen_string_literal: true

class Public::SessionsController < Devise::SessionsController
  # before_action :configure_sign_in_params, only: [:create]
  before_action :reject_customer, only: [:create]
  # GET /resource/sign_in
  # def new
  #   super
  # end

  # POST /resource/sign_in
   #def create
     #super
   #end

  # DELETE /resource/sign_out
  # def destroy
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_in_params
  #   devise_parameter_sanitizer.permit(:sign_in, keys: [:attribute])
  # end

  def after_sign_in_path_for(resource)
    root_path
  end

  def after_sign_out_path_for(resource)
    root_path
  end

  def reject_customer
    @end_user = Customer.find_by(email: params[:customer][:email])
    if @end_user
      if @end_user.valid_password?(params[:customer][:password]) && (@end_user.is_active == false)
        flash[:notice] = "退会済みです。再度ご登録をしてご利用ください"

        redirect_to new_customer_registration_path
      end
    else
      flash[:notice] = "該当するユーザーが見つかりません"
    end
  end






end
