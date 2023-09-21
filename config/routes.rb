Rails.application.routes.draw do
  devise_for :users
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Defines the root path route ("/")
  # root "articles#index"
  root 'pages#home'
  get 'new_file', to: 'pages#new_file'
  post 'upload', to: 'pages#upload'
  get 'new_event', to: 'pages#new_event'
end
