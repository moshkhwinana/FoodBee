
class RecipeController < ApplicationController
  def index
  end

  def show
    @recipe = Recipe.find(params[:id]) # Ensure this matches how you're setting up @recipe
  end

  def generate
    titles = RecipeGenerator.new(params[:ingredients]).generate
  end

  def create
    @recipes = Recipe.new(recipe_params)
  end
end
