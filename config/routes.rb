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

<<<<<<< HEAD
  resources :events
=======
  resources :events do
    resources :check_ins, only: %i[create]
  end
  resources :check_ins, only: %i[index destroy]
    resources :posts
  
  resources :events do
    resources :posts
  end
>>>>>>> 3dd1c472c10b37a3f98688f783957434134514b8
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
