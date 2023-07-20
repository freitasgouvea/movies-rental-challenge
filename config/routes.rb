Rails.application.routes.draw do
  root 'movies#index'

  resources :movies, only: [:index]
  resources :users, only: [:show] do
    get 'recommendations', to: 'users#recommendations', on: :member
    get 'rented_movies', to: 'users#rented_movies', on: :member
  end

  resources :rentals, only: [:create] do
    post 'finish', on: :member
  end
end
