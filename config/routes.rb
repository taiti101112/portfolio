Rails.application.routes.draw do
  # 一般ユーザーがアクセスできるショップの一覧と詳細
  resources :shops, only: [:index, :show]

  # 管理画面用のルーティング
  namespace :admin do
    resources :shops
  end
end