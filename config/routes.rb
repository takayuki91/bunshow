Rails.application.routes.draw do

  devise_for :admins, skip: [:passwords], controllers: {
    registrations: "public/registrations",
    sessions:      "public/sessions"
  }

  devise_for :users, skip: [:registrations, :passwords] ,controllers: {
    sessions: "admin/sessions"
  }

  # ゲストユーザー
  devise_scope :user do
    post 'users/guest_sign_in', to: 'users/sessions#guest_sign_in'
  end

  scope module: :public do

    root to: "homes#top"

    resources :posts do
      resource :likes, only: [:create, :destroy]
      resource :paragons, only: [:create, :destroy]
      resource :bookmarks, only: [:create, :destroy]
      resources :comments, only: [:create, :destroy]
    end

    resources :users, only: [:index,:show,:edit,:update]do
      resource :relationships, only: [:create, :destroy]
      get :follow, on: :member
      get :followed, on: :member
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
