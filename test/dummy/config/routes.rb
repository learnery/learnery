Rails.application.routes.draw do

  mount Learnery::Engine => "/", as: "learnery"
end
