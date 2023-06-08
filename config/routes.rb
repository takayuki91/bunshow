Rails.application.routes.draw do

  devise_for :users, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions:      "public/sessions"
  }

  devise_for :admin, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # ゲストユーザー
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  scope module: :public do

    root to: "homes#top"

    resources :posts, only: [:index, :create, :show, :destroy] do
      resource :likes, only: [:create, :destroy]
      resource :paragons, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :users, only: [:index,:show,:edit,:update]do
      collection do
        get    "unsubscribe"      => "users#unsubscribe", as: "unsubscribe"
        patch  "withdraw"         => "users#withdraw",    as: "withdraw"
      end
      resource :relationships, only: [:create, :destroy]
      get :follows, on: :member
      get :followeds, on: :member
    end

    resources :groups do
      resource :group_users, only: [:create, :destroy]
    end

    resources :communities do
      resource :community_users, only: [:create, :destroy]
    end

  end

  namespace :admin do
    # 後ほど設定
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
