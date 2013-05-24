Learnery::Application.routes.draw do
  resources :rsvps

  devise_for :users#, path_names: {sign_in: "login", sign_out: "logout"}
  get "/pages/:id", to: "pages#show", as: "pages"
  resources :events 
  resource :rsvp, only: [ :create, :update ]
  root 'events#index'
end
