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
      resource :group_users, only: [:create, :destroy]
    end

  end

  namespace :admin do
    get 'top' => 'homes#top', as: 'top'
    resources :users, only: [:index, :show, :edit, :update, :destroy] do
      resources :comments, only: [:index, :show, :destroy]
    end
    resources :posts, only: [:index, :show, :destroy]
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
