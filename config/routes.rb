Rails.application.routes.draw do
  
  #顧客用
  devise_for :customers,controllers:{
    registrations: "public/registrations",
    sesisons: 'public/sessions'
  }  
  
  #管理者用
  devise_for :admin, controllers:{
    sessions: "admin/sessions"
  }
  
  #顧客用
  
  
  #管理者用
  
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
