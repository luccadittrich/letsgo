Rails.application.routes.draw do
  get 'check_ins/index'
  get 'check_ins/create'
  get 'check_ins/destroy'
  devise_for :users
  get '/home', to: 'pages#home'
  devise_scope :user do
    root to: "devise/sessions#new"
  end
  patch '/update_address', to: 'pages#update_address'

  resources :events do
    resources :check_ins, only: %i[create]
  end
  resources :check_ins, only: %i[index destroy]

  resources :events do
    resources :posts
  end
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
