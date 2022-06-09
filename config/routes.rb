Rails.application.routes.draw do
  get 'users', to: 'users#index'
  get 'users/:user_id', to: 'users#show'
end
