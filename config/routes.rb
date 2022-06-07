Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    root to: "devise/sessions#new"
  end

  resources :events
  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
