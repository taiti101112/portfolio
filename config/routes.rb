Rails.application.routes.draw do
  devise_for :users
  # 一般ユーザーがアクセスできるショップの一覧と詳細
  resources :shops, only: [:index, :show]

  # 管理画面用のルーティング
  root 'shops#index' 
  namespace :admin do
    resources :shops
  end
end