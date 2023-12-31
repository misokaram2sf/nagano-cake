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


    post "orders/confirm" => "orders#confirm"
    get "orders/complete" => "orders#complete"
    delete "cart_items/destroy_all" => "cart_items#destroy_all"
    resources :cart_items, only: [:index, :update, :destroy, :create]
    resources :items, only: [:index, :show]
    resources :orders, only: [:new, :index, :show, :create]
    resources :addresses, only: [:index, :edit, :create, :update, :destroy]
    resources :genres, only: [:show]
  end


  #管理者用
  namespace :admin do
    get '/' => 'orders#index'
    resources :items, only: [:index, :new, :create, :show, :edit, :update]
    resources :genres, only: [:index, :create, :edit, :update]
    resources :customers, only: [:index, :show, :edit, :update]
    resources :orders, only: [:index, :show, :update]
    resources :order_details, only: [:update]

  end

 # 退会確認画面
 get  '/customers/check' => 'customers#check'
 # 論理削除用のルーティング
 patch  '/customers/withdraw' => 'customers#withdraw'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
