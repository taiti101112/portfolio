Rails.application.routes.draw do
  devise_for :users, controller: {
    registrations: 'users/registrations',
    session: "users/sessions"
  }
  # 一般ユーザーがアクセスできるショップの一覧と詳細
  resources :shops
  resources :users

  # 管理画面用のルーティング
  root to: 'shops#index' 
  namespace :admin do
    resources :shops
  end
end