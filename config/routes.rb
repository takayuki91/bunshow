Rails.application.routes.draw do

  # ユーザーログイン
  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions:      "public/sessions"
  }

  # 管理者ログイン
  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # ゲストログイン
  devise_scope :user do
    post 'public/guest_sign_in', to: 'public/sessions#guest_sign_in'
  end

  # ユーザー全般
  scope module: :public do

    root to: "homes#top"

    get "search" => "searches#search"

    resources :posts, only: [:index, :create, :show, :destroy] do
      resource :likes, only: [:create, :destroy]
      resource :paragons, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :users, only: [:index,:show,:edit,:update] do
      get :bookmarks, on: :member
      collection do
        get    "unsubscribe"      => "users#unsubscribe", as: "unsubscribe"
        patch  "withdraw"         => "users#withdraw",    as: "withdraw"
      end
      resource :relationships, only: [:create, :destroy]
      get :follows, on: :member
      get :followeds, on: :member
    end

    resources :communities do
      member do
        post 'join'
      end
    end

    resources :groups, only: [:index, :create, :show, :edit, :update, :destroy] do
      get "users" => "groups#users", on: :member
      resource :group_users, only: [:create, :destroy]
    end



  end

  # 管理者全般
  namespace :admin do
    get 'top' => 'homes#top', as: 'top'

    get "search" => "searches#search"

    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:index, :show, :destroy]
    end
    resources :posts, only: [:index, :show, :destroy]
  end

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
