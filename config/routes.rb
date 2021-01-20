Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  delete "/flights/:flight_id/passengers/:passenger_id", to: "flights#destroy"
  resources :flights, only: [:index]
  resources :airlines, only: [:show]
end
