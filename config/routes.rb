Rails.application.routes.draw do
  devise_for :users
  root to: "pages#home"
  resources :products

  # Add a route for a page to gather data for generating recipes
  get "/generate/new", to: "recipes#new_generation", as: "new_generate_recipes"

  post "/generate", to: "recipes#generate", as: "generate_recipes"
  resources :recipes
  resources :favourites
  get "up" => "rails/health#show", as: :rails_health_check
end
