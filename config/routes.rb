Rails.application.routes.draw do
  # 静的ページのルーティング
  get 'privacy_policy', to: 'pages#privacy_policy'
  get 'terms_of_service', to: 'pages#terms_of_service'
  get 'contact', to: 'pages#contact'
  post 'contact', to: 'pages#contact'

  # Deviseによるユーザー認証
  devise_for :users, controllers: {
    registrations: 'users/registrations',
    sessions: 'users/sessions',
    passwords: 'users/passwords'
  }

  # 一般ユーザーがアクセスできるショップの一覧と詳細
  resources :shops, only: [:index, :show] do
    collection do
      get :favorites
      get :map
    end
  end

  # ユーザー管理
  resources :users, only: [:show]

  # お気に入り機能
  resources :favorites, only: %i[create destroy]

  # 管理画面用のルーティング
  namespace :admin do
    resources :shops
  end

  # ルートパス
  root to: 'shops#index'
end
