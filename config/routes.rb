Learnery::Engine.routes.draw do
  resources :topics

  resources :rsvps, only: [ :create, :update ]
  resources :people, only: [ :index, :show, :edit, :update, :destroy ]
  resources :events

  namespace :admin do
    resources :events
  end

#http://guides.rubyonrails.org/routing.html#specifying-a-controller-to-use
scope module: :learnery do
  #https://github.com/plataformatec/devise/wiki/How-To:-Use-devise-inside-a-mountable-engine
  devise_for :users, :class_name => 'Learnery::User',
    module: :devise,
    controllers: {omniauth_callbacks: "omniauth_callbacks",
                  registrations: 'my_registrations'}
  end

  get "/pages/:id", to: "pages#show", as: "pages"
  root 'events#index'
end


