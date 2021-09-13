Rails.application.routes.draw do
  get 'users/show'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  root to: 'homes#top'

  resources :post_images, only: [:new, :create, :index, :show, :destroy] do
    resource :favorites, only:[:create, :destroy]

    resources :post_comments, only: [:create, :destroy]
  end

  resources :users, only: [:index, :show, :edit, :update] do

  #フォローフォロワー機能のルーティング
  resource :relationships, only: [:create, :destroy]
  get 'followings' => 'relationships#followings', as: 'followings'
  get 'followers' => 'relationships#followers', as: 'followers'
  get "relationships/followings"
  end

end