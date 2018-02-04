Rails.application.routes.draw do
  resources :tournaments, only: [:create]
end
