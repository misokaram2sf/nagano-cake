Rails.application.routes.draw do

  #顧客用
  devise_for :customers, skip: [:passwords], controllers:{
    registrations: "public/registrations",
    sessions: 'public/sessions'
  }

  #管理者用
  devise_for :admin, skip: [:registrations, :passwords], controllers:{
    sessions: "admin/sessions"
  }

  #顧客用
  scope module: :public do
    root to: 'homes#top'
    get "home/about" => "homes#about", as: "about"
    get "customers/mypage" => "customers#show"
    get "customers/information/edit" => "customers#edit"
    patch "customers/information" => "customers#update"
    get "customers/confirm" => "customers#confirm"
    patch "customers/withdrawal" => "customers#withdrawal"

    resources :cart_items, only: [:index, :update, :destroy, :create]
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :index, :show]
    post "orders/confirm" => "orders#confirm"
    get "orders/complete" => "orders#complete"
    post "orders" => "orders#create"
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
  end


  #管理者用
  namespace :admin do
    get 'homes/top' => 'homes#top'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:show, :update]
    resources :order_details, only: [:update]

  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
