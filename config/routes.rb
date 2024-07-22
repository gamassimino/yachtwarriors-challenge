Rails.application.routes.draw do
  root "loans#index"

  resources :loans, only: [:index, :create]
end
