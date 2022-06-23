Rails.application.routes.draw do
  devise_for :users
  root "users#index"
  resources :users, only: [:index, :show] do
    resources :posts, only: [:index, :new, :show, :create, :destroy]
  end

  resources :posts do
    resources :comments, only: [:new, :create, :destroy]
    resources :likes, only: [:create]
  end
end
