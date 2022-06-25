Rails.application.routes.draw do
  devise_for :users,
              controllers: {
                sessions: 'users/sessions',
                registrations: 'users/registration'
              }

  root "users#index"
  resources :users, only: [:index, :show, :edit, :update] do
    resources :posts, only: [:index, :new, :show, :create, :destroy]
  end

  resources :posts do
    resources :comments, only: [:create, :index]
    resources :likes, only: [:create]
  end

  namespace :api do
    namespace :v1 do
      resources :users, only: [:index]
      resources :posts, only: [] do
        resources :comments, only: [:index, :create]
      end
    end
  end
end
