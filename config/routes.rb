Rails.application.routes.draw do
  # 一般ユーザーがアクセスできるショップの一覧と詳細
  resources :shops, only: [:index, :show]
  resources :users

  # 管理画面用のルーティング
  root 'shops#index' 
  namespace :admin do
    resources :shops
  end
end