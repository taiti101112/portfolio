Rails.application.routes.draw do
  devise_for :users, controller: {
    registrations: 'users/registrations',
    session: "users/sessions"
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