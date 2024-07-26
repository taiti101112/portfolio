Rails.application.routes.draw do
  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'terms_of_service', to: 'pages#terms_of_service'
  get 'contact', to: 'pages#contact'
  post 'contact', to: 'pages#contact'
  devise_for :users, controller: {
    registrations: 'users/registrations',
    session: "users/sessions",
    passwords: 'users/passwords'
  }
  # 一般ユーザーがアクセスできるショップの一覧と詳細
  resources :shops do
    collection do
      get :favorites
    end
  end
  resources :users
  resources :favorites, only: %i[create destroy]

  # 管理画面用のルーティング
  root to: 'shops#index' 
  namespace :admin do
    resources :shops
  end
end