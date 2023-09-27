Rails.application.routes.draw do
  post '/auth/login', to: 'authentication#login'

  resources :comments
  resources :posts
  resources :users
end
