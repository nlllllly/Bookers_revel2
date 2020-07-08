Rails.application.routes.draw do
  # rootのindexを設定する
  root 'home#index'
  # deivseをインストールしたら入ってくる。「users」にdeivseが使われてると表記。
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  # リソースを表記　homeをresourceにして、aboutをその下にネストしている。
  resources :books, only: [:index, :show, :create, :edit, :update, :destroy]
  resource :home, only: [:index] do
    resources :about, only: [:index]
  end  
  resources :users, only: [:index, :show, :edit, :update]
end
