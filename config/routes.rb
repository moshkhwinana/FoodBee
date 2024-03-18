Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :products

  # Add a route for a page to gather data for generating recipes
  get "/generate/new", to: "recipes#new_generation", as: "new_generate_recipes"

  post "/generate", to: "recipes#generate", as: "generate_recipes"
  resources :recipes do
    resources :favourites, only: [:create]
  end
  resources :favourites, only: [:index, :destroy]
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check
end
