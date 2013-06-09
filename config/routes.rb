Learnery::Application.routes.draw do
  resources :topics

  resources :rsvps, only: [ :create, :update ]
  resources :people, only: [ :index, :show, :edit, :update, :destroy ]
  resources :events

  devise_for :users, controllers: {omniauth_callbacks: "omniauth_callbacks"}
  #, path_names: {sign_in: "login", sign_out: "logout"}

  get "/pages/:id", to: "pages#show", as: "pages"
  root 'events#index'
end
