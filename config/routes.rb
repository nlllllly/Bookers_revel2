Rails.application.routes.draw do
  get 'users/show'
  root 'home#index'
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  resources :users
  resource :home, only: [:index] do
    resources :about, only: [:index]
  end  
  resources :books, only: [:index, :show]
end
